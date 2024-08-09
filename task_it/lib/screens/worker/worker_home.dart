import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/widgets/indicator.dart'; // Import your custom widget

class WorkerHome extends StatefulWidget {
  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
  int totalTasks = 0;
  int completedTasks = 0;
  String? workerName;

  @override
  void initState() {
    super.initState();
    fetchTasks();
    getWorkerName(); // Added to fetch worker name
  }

  Future<void> fetchTasks() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .where('worker', isEqualTo: user.displayName)
          .get();

      int completed = 0;
      int remaining = 0;

      for (var doc in snapshot.docs) {
        if (doc['status'] == 'Completed') {
          completed++;
        } else {
          remaining++;
        }
      }

      setState(() {
        totalTasks = snapshot.size;
        completedTasks = completed;
      });
    }
  }

  Future<void> getWorkerName() async {
    // Added to fetch worker name
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user
              .uid) // Assuming worker details are stored in users collection
          .get();

      if (docSnapshot.exists) {
        setState(() {
          workerName =
              docSnapshot.data()!['name']; // Assuming name field exists
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: _buildAppBar(),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Daily Task Completion',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskCompletionIndicator(
                  allTasks: totalTasks,
                  completedTasks: completedTasks,
                ),
                Column(
                  children: [
                    Text(
                      'Tasks Remaining: ${totalTasks - completedTasks}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: kBlack,
                      ),
                    ),
                    Text(
                      'Tasks Completed: $completedTasks',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: kBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('tasks')
                    .where('worker',
                        isEqualTo:
                            FirebaseAuth.instance.currentUser?.displayName)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var tasks = snapshot.data!.docs;
                  if (tasks.isEmpty) {
                    return Center(child: Text('You have no tasks assigned.'));
                  }

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
                                _showManualInputDialog(task);
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
                              'Time: ${task['dueTime']} \n ${task['category']}'),
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

  void _showManualInputDialog(DocumentSnapshot task) {
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
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Amount',
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('tasks')
                        .doc(task.id)
                        .update({
                      'manualInputAmount': int.tryParse(amountController.text),
                      'status': 'Completed',
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          );
        });
  }

  Widget _buildAppBar() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome, ${FirebaseAuth.instance.currentUser?.displayName}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Icon(Icons.more_vert, color: Colors.black, size: 40),
          ],
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
            ]),
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
                    label: 'Home', icon: Icon(Icons.home_rounded, size: 40)),
                BottomNavigationBarItem(
                    label: 'Finances',
                    icon: Icon(Icons.attach_money_outlined, size: 40)),
                BottomNavigationBarItem(
                    label: 'Person',
                    icon: Icon(Icons.person_rounded, size: 40)),
              ],
            )));
  }
}
