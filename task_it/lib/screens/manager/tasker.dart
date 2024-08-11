import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/screens/manager/addtask.dart';
import 'package:task_it/screens/manager/preview.dart';
import 'package:task_it/screens/manager/progress.dart';

class Tasker extends StatefulWidget {
  @override
  _TaskerState createState() => _TaskerState();
}

class _TaskerState extends State<Tasker> {
  String _taskFilter = 'All Tasks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: _buildAppBar(),
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
                DropdownButton<String>(
                  value: _taskFilter,
                  items:
                      ['All Tasks', 'Completed', 'Pending'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: kBlack,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _taskFilter = newValue!;
                    });
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTask()),
                    );
                  },
                  child: Text(
                    'Add Task+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('tasks').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No tasks available'));
                  }

                  final tasks = snapshot.data!.docs;
                  final filteredTasks = tasks.where((task) {
                    if (task['isPersonal'] == true) {
                      return false;
                    }
                    if (_taskFilter == 'All Tasks') {
                      return true;
                    }
                    if (_taskFilter == 'Completed') {
                      return task['status'] == 'Completed';
                    }
                    if (_taskFilter == 'Pending') {
                      return task['status'] == 'Pending';
                    }
                    return false;
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final title = task['title'] ?? 'No Title';
                      final worker = task['worker'] ?? 'No Worker';
                      final status = task['status'] ?? 'Pending';
                      final statusColor =
                          status == 'Completed' ? Colors.green : Colors.red;

                      return Card(
                        child: ListTile(
                          isThreeLine: true,
                          title: Text(
                            title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Worker: $worker'),
                              Text('Task Status: $status',
                                  style: TextStyle(color: statusColor)),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_outlined, color: kRedDark),
                            onPressed: () {
                              _deleteTask(task.id);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTask(task: task),
                              ),
                            );
                          },
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

  void _deleteTask(String taskId) {
    FirebaseFirestore.instance.collection('tasks').doc(taskId).delete();
  }

  Widget _buildAppBar() {
    return Material(
      elevation: 0,
      child: ClipRRect(
        child: AppBar(
          backgroundColor: kBlack,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'WORK',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            GestureDetector(
              child:Icon(Icons.circle),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProgressTracker()),
                );
              },
            )
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
          ),
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
                label: 'Home', icon: Icon(Icons.home_rounded, size: 40)),
            BottomNavigationBarItem(
                label: 'Finances',
                icon: Icon(Icons.attach_money_outlined, size: 40)),
            BottomNavigationBarItem(
                label: 'Person', icon: Icon(Icons.person_rounded, size: 40)),
          ],
        ),
      ),
    );
  }
}