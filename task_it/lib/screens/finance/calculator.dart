import 'package:cloud_firestore/cloud_firestore.dart';

class Calculations {
  Future<void> processCompletedFinanceTasks() async {
    int personalIncomeBalance = 0;
    int personalExpenseBalance = 0;
    int workIncomeBalance = 0;
    int workExpenseBalance = 0;

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);

    // Query for completed finance tasks that have not been processed yet
    final snapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('category', isEqualTo: 'Finance')
        .where('status', isEqualTo: 'Completed')
        .where('isProcessed', isEqualTo: false) // Add this condition
        .get();

    for (var doc in snapshot.docs) {
      var taskData = doc.data();
      bool isPersonal = taskData['isPersonal'] ?? true;

      int amount = taskData['amount'] ?? 0;
      String financeType = taskData['financeType'] ?? '';

      if (isPersonal) {
        if (financeType == 'Income') {
          personalIncomeBalance += amount;
        } else if (financeType == 'Expense') {
          personalExpenseBalance += amount;
        }
      } else {
        if (financeType == 'Income') {
          workIncomeBalance += amount;
        } else if (financeType == 'Expense') {
          workExpenseBalance += amount;
        }
      }

      // Mark this task as processed
      await doc.reference.update({'isProcessed': true});
    }

    // Check if there's already an entry for today
    final balanceDoc = await FirebaseFirestore.instance
        .collection('balances')
        .where('entryDate', isEqualTo: Timestamp.fromDate(today))
        .get();

    if (balanceDoc.docs.isNotEmpty) {
      // Update existing document
      DocumentReference docRef = balanceDoc.docs.first.reference;

      docRef.update({
        'personalIncomeBalance': FieldValue.increment(personalIncomeBalance),
        'personalExpenseBalance': FieldValue.increment(personalExpenseBalance),
        'workIncomeBalance': FieldValue.increment(workIncomeBalance),
        'workExpenseBalance': FieldValue.increment(workExpenseBalance),
      });
      print('Balances updated.');
    } else {
      // Create new document if it doesn't exist
      await FirebaseFirestore.instance.collection('balances').add({
        'entryDate': today,
        'personalIncomeBalance': personalIncomeBalance,
        'personalExpenseBalance': personalExpenseBalance,
        'workIncomeBalance': workIncomeBalance,
        'workExpenseBalance': workExpenseBalance,
      });
      print('New balances document created.');
    }
  }
}