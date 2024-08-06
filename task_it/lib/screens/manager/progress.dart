import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/widgets/indicator.dart';

class ProgressTracker extends StatefulWidget {
  const ProgressTracker({Key? key}) : super(key: key);

  @override
  State<ProgressTracker> createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  int totalTasks = 0;
  int completedTasks = 0;
  int remainingTasks = 0;
  Map<String, Map<String, int>> workerTasks = {};

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('isPersonal', isEqualTo: false)
        .get();

    int total = 0;
    int completed = 0;
    Map<String, Map<String, int>> workers = {};

    for (var doc in snapshot.docs) {
      total++;
      if (doc['status'] == 'Completed') {
        completed++;
      }

      String worker = doc['worker'];
      if (workers.containsKey(worker)) {
        workers[worker]!['total'] = workers[worker]!['total']! + 1;
        if (doc['status'] == 'Completed') {
          workers[worker]!['completed'] = workers[worker]!['completed']! + 1;
        }
      } else {
        workers[worker] = {
          'total': 1,
          'completed': doc['status'] == 'Completed' ? 1 : 0
        };
      }
    }

    setState(() {
      totalTasks = total;
      completedTasks = completed;
      workerTasks = workers;
      remainingTasks = total - completed;
    });
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
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TaskCompletionIndicator(
                        allTasks: totalTasks,
                        completedTasks: completedTasks,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Tasks Remaining: ${remainingTasks}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: kBlack,
                        ),
                      ),
                      Text(
                        'Tasks Completed: ${completedTasks}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: kBlack,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: workerTasks.entries.map((entry) {
                    String worker = entry.key;
                    int workerTotal = entry.value['total']!;
                    int workerCompleted = entry.value['completed']!;
                    int workerRemaining = workerTotal - workerCompleted;

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        bottomLeft: Radius.circular(0.0),
                        bottomRight: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      )),
                      child: ListTile(
                        title: Text(
                          worker,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Completion: ${(workerCompleted / workerTotal * 100).toStringAsFixed(2)}%'),
                            Text('Tasks Left: $workerRemaining'),
                          ],
                        ),
                        trailing: TaskCompletionIndicator(
                          allTasks: workerTotal,
                          completedTasks: workerCompleted,
                        ),
                        isThreeLine: true,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
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
            children: [
              Text(
                'WORK PROGRESS',
                style: TextStyle(
                  color: Colors.black,
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
                  label: 'Person', icon: Icon(Icons.person_rounded, size: 40)),
            ],
          )));
}
