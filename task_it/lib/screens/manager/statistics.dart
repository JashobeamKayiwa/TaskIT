import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_it/screens/bottom_sheets/google_sheets.dart';
import 'package:task_it/screens/bottom_sheets/loading_circle.dart';
import 'package:task_it/screens/bottom_sheets/plus_button.dart';
import 'package:task_it/screens/bottom_sheets/top_card.dart';
import 'package:task_it/screens/bottom_sheets/transaction.dart';

class Statistics extends StatefulWidget {
  const Statistics({super.key});

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  final textcontrollerAmount = TextEditingController();
  final textcontrollerItem = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isIncome = false;
  bool timerHasStarted = false;

  void addTransaction() {
    GoogleSheetsApi.insert(
      textcontrollerAmount.text,
      textcontrollerItem.text,
      isIncome,
    );
    setState(() {});
    textcontrollerAmount.clear();
    textcontrollerItem.clear();
    isIncome = false;
  }

  void newTransaction() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('N E W   T R A N S A C T I O N'),
              content: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300), // Constrain width
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            value: isIncome,
                            activeColor: Colors.blue,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[300],
                            onChanged: (newValue) {
                              setState(() {
                                isIncome = newValue;
                              });
                            },
                          ),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: textcontrollerItem,
                              decoration: InputDecoration(
                                hintText: 'Enter Amount',
                                border: OutlineInputBorder(),
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Field required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: textcontrollerAmount,
                              decoration: InputDecoration(
                                hintText: 'Enter Transaction Name',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.grey[600]),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.grey[600]),
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      addTransaction();
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetsApi.loading == true && !timerHasStarted) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: _buildAppBar(context),
      ),
      floatingActionButton: PlusButton(
        function: newTransaction,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            TopCard(
              balance: (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
              expense: GoogleSheetsApi.calculateExpense().toString(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      'View all',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.arrow_downward,
                      size: 15,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: GoogleSheetsApi.loading == true
                  ? Center(child: LoadingCircle())
                  : ListView.builder(
                      itemCount: GoogleSheetsApi.currentTransactions.length,
                      itemBuilder: (context, index) {
                        return MyTransaction(
                          transactionName:
                              GoogleSheetsApi.currentTransactions[index][0],
                          money: GoogleSheetsApi.currentTransactions[index][1],
                          expenseOrIncome:
                              GoogleSheetsApi.currentTransactions[index][2],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final String balance =
        (GoogleSheetsApi.calculateIncome() - GoogleSheetsApi.calculateExpense())
            .toString();
    return Material(
      elevation: 0,
      child: ClipRRect(
        child: Container(
          color: Colors.black,
          child: Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    'Shs.' + balance,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
