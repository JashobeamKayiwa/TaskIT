import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  static const credentials = r'''
{
  "type": "service_account",
  "project_id": "expense-tracker-app-431312",
  "private_key_id": "671a4a86371d7c947c95da53147fae120e194d26",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDR0Z9j8HeQ3ld2\nN5i/ww5WAXENM/L7Wi7Do5mKMPTEBgR+EanS58ogiEIAKFxDCVfEkYBK1kmyQdnS\ne6R2MowtPJTuos+CotHEfrwRyuwtENrJF64gup+63PakHD2TASDLxRzFORNEn+v7\nHdzFe4vCeDTvwvBmjHMPYpCAAjFFXk/uWSNWVSJMhOG+B9akhrlRxqQmnwFHsmI5\n03DALoZCyWYvqjAL1zc5aoRaxjQqrrQmblwn9m+8ZJyWpDAQlZAruRuxJ8chjk5I\nguTA09eTQSgDHnDOEY31njyDHt8JAgrtReEtMj4RW8zTCjfB2Wzv43MyCe9w0dS9\n0uHv2m7BAgMBAAECggEADi1/ECKngFLB2rNgNImn45W2hP5Ju4Rzwf+r8uuix8ch\n+78novXLfEjGGvAfPIlk/0ZCAsHkRMcQgq7yT+lTpwU1CW4CHcabluPlw0Gwv/fS\nV4HB3/ofASJdXn1TsiYCnbpMms1j7lXBvUbJNvqa7kcEnrSPsteSjnYqI6LiSkNO\ngMUYSpZjs/9miGndeW36oHXBuOluqixvs3HksKf5FVC1PhhE+xkDWXJbNZxebA8W\nS+p8GT814XBuqLQJxQ1S7LzWqq9LmMZwhttMgTn323cx4SLxpx2tVXE6WC4N+0uO\nx3BVAihYGGGViKFYAwfO4JPnU5H7U3FEHdUGITzf1QKBgQD9PQZVKM8Bn3Dwpj4i\nUwl4ijfuahbzB1WliSQblIEKOQzcdtDca/Je9fIpBaJZtRy0tStyP7ZTBGfhfPLg\nLSIACUo+k2FviY1eXwo0wtW1IgsPtiPK8t1SKwhSaqLTBb9PmnFg5U8B4MV3/ie/\n4DVYy7A2/TiVlIHJo3+ODjr3BQKBgQDUG2HDvNhC8ZqV5+7mpcvF4J6Np+KJNDPC\nE/rduc9E9XP0wtM0R+K84kl6whmEqAlchMoJDDuYgv9P5rLv5G3Caih8yWpGiUPl\nSD56P4Ky8DaoatZ2Wn+dKHLTz5z5VbelI8b2Z0RTBBQrvwuBC+eOXpvnKDjH/Dyl\nLQ6UxUqtjQKBgD0qAR6Odbkpnmixbm5x6eawU6QFAbf/PIN35T24F5a1gtK46+dh\nNzASbUPVNYo/QUiwPWch1lKkzMZcnHjizcR+ee01QaJj8b4qbFej+2P9bfiEgI6j\nLCuNczwcv2kCiVubrOi/Wd7VQDykKUuhxqDEybHuZT1TmilukP9plnpVAoGBALQb\ntD6jwvfFdMDKO4C7VHdorvoWjzR2kWTB1ook1630x0wVi4afbBd8B20oGMcecSSQ\n1YYtTwXIZsgQW+18iP9Haa3c0lOnB3JQkEz6VR9g/uiwIABMBIUM7cSSTPckJFck\nNDTTp57encov5bLkyvGHwNbevqiCtXSE+Ba4GRuZAoGBAKSjlzjP3niYdElKa4kG\noDJemqApgTLv+pPlh2SUtWcUDiiPK4wq7oDDXb4qkSk+d0fmSf0+8kFVH6pIO7sm\nO6zn1VoS117IjbQ6SUAerADoagQaccTyfZ7E+5FVNRa6vfqLImtFT/IxSF5gm398\nb0GFvE8j9SZF5WAPISZVjf9Z\n-----END PRIVATE KEY-----\n",
  "client_email": "expense-tracker-app@expense-tracker-app-431312.iam.gserviceaccount.com",
  "client_id": "112818440626878112006",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expense-tracker-app%40expense-tracker-app-431312.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}


''';

  static final spreadsheetId = '1vC6p1_1Bko9xSQK4VruZklV1ryBkbZBdxe9AzynlZkI';
  static final gsheets = GSheets(credentials);
  static Worksheet? worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;
  static double totalIncome = 0.0;
  static double totalExpense = 0.0;
  static double balance = 0.0;

  static Future<void> init() async {
    final ss = await gsheets.spreadsheet(spreadsheetId);
    worksheet = ss.worksheetByTitle('Worksheet1');
    await _fetchData();
  }

  static Future<void> _fetchData() async {
    List<List<dynamic>> allRows = await worksheet!.values.allRows();

    // Skip the first row (header)
    currentTransactions = allRows.skip(1).map((row) {
      final name = row[0] as String;
      final amount = row[1] as String;
      final type = row[2] as String;
      final date = row[3] as String;
      final status = row[4] as String;

      return [
        name,
        amount,
        type,
        date,
        status.toLowerCase() == 'completed' ? true : false,
      ];
    }).toList();
    _recalculateTotals();
    loading = false;
  }

  static void _recalculateTotals() {
    totalIncome = 0.0;
    totalExpense = 0.0;

    for (var transaction in currentTransactions) {
      if (transaction[4] == true) {
        // Only count if transaction is checked
        if (transaction[2] == 'income') {
          totalIncome += double.parse(transaction[1]);
        } else if (transaction[2] == 'expense') {
          totalExpense += double.parse(transaction[1]);
        }
      }
    }

    balance = totalIncome - totalExpense;
  }

  static Future<void> insert(String name, String amount, bool isIncome) async {
    if (worksheet == null) return;

    // Get the current date
    String currentDate = DateTime.now().toIso8601String();

    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      isIncome == true ? 'income' : 'expense',
      currentDate,
      false, // Default to not completed
    ]);

    await worksheet!.values.appendRow([
      name,
      amount,
      isIncome == true ? 'income' : 'expense',
      currentDate,
      'Incomplete' // Default value for the new "Completed" column
    ]);
    await _fetchData(); // Refresh the current transactions
  }

  static Future<void> markAsCompleted(int rowIndex) async {
    if (worksheet == null) return;

    // Ensure the row index is valid and within the current range
    if (rowIndex < 0 || rowIndex >= currentTransactions.length) return;

    // Update the "Completed" column for the specified row
    await worksheet!.values.insertValue(
      'Completed',
      row: rowIndex + 2, // +2 to account for header row and zero-based index
      column:
          5, // Column index for "Completed" (5 is the 6th column, zero-based)
    );
    currentTransactions[rowIndex][4] = true;

    await _fetchData(); // Refresh the current transactions
  }

  static Future<void> markAsIncomplete(int rowIndex) async {
    if (worksheet == null) return;

    // Ensure the row index is valid and within the current range
    if (rowIndex < 0 || rowIndex >= currentTransactions.length) return;

    // Update the "Completed" column for the specified row
    await worksheet!.values.insertValue(
      'Incomplete',
      row: rowIndex + 2, // +2 to account for header row and zero-based index
      column:
          5, // Column index for "Completed" (5 is the 6th column, zero-based)
    );
    currentTransactions[rowIndex][4] = false;

    await _fetchData(); // Refresh the current transactions
  }

  static double calculateIncome() {
    double totalIncome = 0;
    for (var transaction in currentTransactions) {
      if (transaction[2] == 'income' && transaction[4]) {
        totalIncome += double.parse(transaction[1]);
      }
    }
    return totalIncome;
  }

  static double calculateExpense() {
    double totalExpense = 0;
    for (var transaction in currentTransactions) {
      if (transaction[2] == 'expense' && transaction[4]) {
        totalExpense += double.parse(transaction[1]);
      }
    }
    return totalExpense;
  }

  static Future loadTransactions() async {
    if (worksheet == null) return;

    for (int i = 1; i <= numberOfTransactions; i++) {
      final String transactionName =
          await worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await worksheet!.values.value(column: 3, row: i + 1);
      final String transactionDate =
          await worksheet!.values.value(column: 4, row: i + 1);
      final String transactionStatus =
          await worksheet!.values.value(column: 5, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
          transactionDate,
          transactionStatus == 'Completed' ? true : false,
        ]);
      }
    }
    loading = false;
  }
}
