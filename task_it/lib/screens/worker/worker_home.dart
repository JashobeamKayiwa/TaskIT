import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_it/constants/colors.dart';

class WorkerPage extends StatefulWidget {
  @override
  _WorkerPageState createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userName = userSnapshot['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: _buildAppBar(context),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: kWhite,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .where('worker', isEqualTo: userName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var tasks = snapshot.data!.docs;
                  tasks.sort((a, b) {
                    bool aCompleted = a['status'] == 'Completed';
                    bool bCompleted = b['status'] == 'Completed';
                    return aCompleted && !bCompleted ? 1 : -1;
                  });

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      bool isCompleted = task['status'] == 'Completed';
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: kBlack,
                            value: isCompleted,
                            onChanged: (bool? value) {
                              if (task['manualInput'] == true &&
                                  value == true) {
                                _showManualInputDialog(context, task);
                              } else {
                                FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(task.id)
                                    .update({
                                  'status': value! ? 'Completed' : 'Pending',
                                });
                              }
                            },
                          ),
                          isThreeLine: true,
                          title: Text(
                            task['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(
                            'Time: ${task['dueTime']} \n ${task['category']}',
                          ),
                          tileColor:
                              isCompleted ? kGrey.withOpacity(0.5) : kWhite,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  void _showManualInputDialog(BuildContext context, DocumentSnapshot task) {
    TextEditingController amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter Amount',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  errorText: amountController.text.isNotEmpty &&
                          int.tryParse(amountController.text) == null
                      ? 'Please enter a valid integer'
                      : null,
                ),
                onChanged: (value) {
                  // Force rebuild to update the error text
                  (context as Element).markNeedsBuild();
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int? manualAmount = int.tryParse(amountController.text);
                  if (manualAmount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please input a valid integer')),
                    );
                    return;
                  }

                  FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(task.id)
                      .update({
                    'manualInputAmount': manualAmount,
                    'status': 'Completed',
                  });
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Material(
      elevation: 0,
      child: ClipRRect(
        child: AppBar(
          backgroundColor: kBlack,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'Assignments',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: kBlack,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_rounded, size: 40),
            ),
            BottomNavigationBarItem(
              label: 'Finances',
              icon: Icon(Icons.attach_money_outlined, size: 40),
            ),
            BottomNavigationBarItem(
              label: 'Person',
              icon: Icon(Icons.person_rounded, size: 40),
            ),
          ],
        ),
      ),
    );
  }
}
