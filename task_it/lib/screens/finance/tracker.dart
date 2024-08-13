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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: _buildAppBar(screenWidth),
      ),
      body:
      
       FutureBuilder<void>(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Personal',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Switch(
                    activeColor: Colors.blue,
                    value: showPersonal,
                    onChanged: (bool value) {
                      setState(() {
                        showPersonal = value;
                      });
                    },
                  ),
                  Text('Work',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  iconEnabledColor: Colors.black,
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
                      child: Text(value, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Tasks",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('tasks')
                              .where('isPersonal', isEqualTo: showPersonal)
                              .where('category', isEqualTo: 'Finance')
                              .where('status', isEqualTo: 'Completed')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return Center(child: Text('No tasks found.'));

                            var tasks = snapshot.data!.docs;

                            return Column(
                              children: tasks.map((task) {
                                var taskData =
                                    task.data() as Map<String, dynamic>;
                                return Card(
                                  child: ListTile(
                                    // isThreeLine: true,
                                    title: Text(taskData['title'] ?? 'No Title', style: TextStyle(fontSize: 20.0),),
                                    trailing:
                                        Text('UGX${taskData['amount'] ?? 0}',style: TextStyle(color : taskData['financeType']=='Income'  ? Colors.green : Colors.red,fontSize: 20.0)),
                                  ),
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
          title: Text('$label Income Balance',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          trailing: Text('UGX$income',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color:Colors.green),),
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.arrow_downward, color: Colors.red),
          title: Text('$label Expense Balance',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          trailing: Text('UGX$expense',style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color:Colors.red)),
        ),
      ),
      Card(
        child: ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text('Total $label Earnings',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          trailing: Text(
            'UGX$total',
            style: TextStyle(
              color: total < 0 ? Colors.red : Colors.green,
              fontSize: 15.0
            ),
          ),
        ),
      ),
    ];
  }
  Widget _buildAppBar(double screenWidth) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'Finance Tracker',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
