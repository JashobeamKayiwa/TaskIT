import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_it/screens/finance/calculator.dart';

class TrackerPage extends StatefulWidget {
  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  bool showPersonal = true;

  // Future to hold the initialization process
  late Future<void> initializationFuture;

  // Selected date range option
  String selectedDateRange = 'Today';

  @override
  void initState() {
    super.initState();
    // Initialize the future
    initializationFuture = Calculations().processCompletedFinanceTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracker Page'),
      ),
      body: FutureBuilder<void>(
        future: initializationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the future to complete
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that might occur during processing
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Proceed with rendering the UI after the future is complete
          return Column(
            children: [
              SwitchListTile(
                title: Text('Show Personal / Work Details'),
                value: showPersonal,
                onChanged: (bool value) {
                  setState(() {
                    showPersonal = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.transparent,
                  value: selectedDateRange,
                  items: <String>[
                    'Today',
                    'Tomorrow',
                    'Yesterday',
                    'This Week',
                    'This Month'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDateRange = newValue!;
                    });
                  },
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('balances')
                      .where(
                        'entryDate',
                        isGreaterThanOrEqualTo:
                            _getStartDate(selectedDateRange),
                        isLessThanOrEqualTo: _getEndDate(selectedDateRange),
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();

                    var balancesDocs = snapshot.data!.docs;

                    if (balancesDocs.isEmpty) {
                      return Center(child: Text('No balances found.'));
                    }

                    var balances =
                        balancesDocs.first.data() as Map<String, dynamic>;

                    int personalIncomeBalance =
                        balances['personalIncomeBalance'] ?? 0;
                    int personalExpenseBalance =
                        balances['personalExpenseBalance'] ?? 0;
                    int workIncomeBalance = balances['workIncomeBalance'] ?? 0;
                    int workExpenseBalance =
                        balances['workExpenseBalance'] ?? 0;

                    int totalPersonalEarnings =
                        personalIncomeBalance - personalExpenseBalance;
                    int totalWorkEarnings =
                        workIncomeBalance - workExpenseBalance;

                    return ListView(
                      children: [
                        if (showPersonal)
                          ...buildBalanceCards(
                            personalIncomeBalance,
                            personalExpenseBalance,
                            totalPersonalEarnings,
                            'Personal',
                          ),
                        if (!showPersonal)
                          ...buildBalanceCards(
                            workIncomeBalance,
                            workExpenseBalance,
                            totalWorkEarnings,
                            'Work',
                          ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('tasks')
                              .where('isPersonal', isEqualTo: showPersonal)
                              .where('category', isEqualTo: 'Finance')
                              .where('status',
                                  isEqualTo:
                                      'Completed') // Filter for completed tasks
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();

                            var tasks = snapshot.data!.docs;

                            return Column(
                              children: tasks.map((task) {
                                var taskData =
                                    task.data() as Map<String, dynamic>;
                                return ListTile(
                                  title: Text(taskData['title'] ?? 'No Title'),
                                  trailing:
                                      Text('\$${taskData['amount'] ?? 0}'),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Calculate the start date based on the selected date range
  Timestamp _getStartDate(String dateRange) {
    DateTime now = DateTime.now();
    DateTime start;

    switch (dateRange) {
      case 'Today':
        start = DateTime(now.year, now.month, now.day);
        break;
      case 'Tomorrow':
        start = DateTime(now.year, now.month, now.day + 1);
        break;
      case 'Yesterday':
        start = DateTime(now.year, now.month, now.day - 1);
        break;
      case 'This Week':
        int weekDay = now.weekday;
        start = now.subtract(Duration(days: weekDay - 1)); // Start of the week
        break;
      case 'This Month':
        start = DateTime(now.year, now.month, 1);
        break;
      default:
        start = DateTime(now.year, now.month, now.day);
    }
    return Timestamp.fromDate(start);
  }

  // Calculate the end date based on the selected date range
  Timestamp _getEndDate(String dateRange) {
    DateTime now = DateTime.now();
    DateTime end;

    switch (dateRange) {
      case 'Today':
        end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        break;
      case 'Tomorrow':
        end = DateTime(now.year, now.month, now.day + 1, 23, 59, 59, 999);
        break;
      case 'Yesterday':
        end = DateTime(now.year, now.month, now.day - 1, 23, 59, 59, 999);
        break;
      case 'This Week':
        int weekDay = now.weekday;
        end = now.add(Duration(days: 7 - weekDay));
        end = DateTime(
            end.year, end.month, end.day, 23, 59, 59, 999); // End of the week
        break;
      case 'This Month':
        end = DateTime(now.year, now.month + 1, 1).subtract(Duration(days: 1));
        end = DateTime(end.year, end.month, end.day, 23, 59, 59, 999);
        break;
      default:
        end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    }
    return Timestamp.fromDate(end);
  }

  List<Widget> buildBalanceCards(
      int income, int expense, int total, String label) {
    return [
      Card(
        child: ListTile(
          leading: Icon(Icons.arrow_upward, color: Colors.green),
          title: Text('$label Income Balance'),
          trailing: Text('\$$income'),
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.arrow_downward, color: Colors.red),
          title: Text('$label Expense Balance'),
          trailing: Text('\$$expense'),
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text('Total $label Earnings'),
          trailing: Text('\$$total'),
        ),
      ),
    ];
  }
}
