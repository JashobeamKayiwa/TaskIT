import 'package:flutter/material.dart';
import 'package:task_it/pages/admin_home.dart';
import 'package:task_it/requirements/colors.dart';

class AdminWork extends StatefulWidget {
  const AdminWork({super.key});

  @override
  State<AdminWork> createState() => _AdminWorkState();
}

class _AdminWorkState extends State<AdminWork> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Work Progress', style: TextStyle(fontWeight: FontWeight.bold),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AdminHome()));
            },
          ),
        ),
        body:Column(
        children: [
          Divider(height: 1, color: Colors.grey), 
          Expanded(
          child: WorkProgressScreen(),),
          ],),
          bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

class WorkProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: 1-0.55,
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                        strokeWidth: 10,
                      ),
                    ),
                    Text(
                      '55%',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ],
                ),
                Container(
                  width: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('27 Tasks Left', style: TextStyle(fontSize: 18)),
                        Text('34 Tasks Complete', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          Center(
          child: Text('Staff Progress', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Replace with the actual number of staff members
              itemBuilder: (context, index) {
                return StaffProgress(
                  name: 'Staff Member $index',
                  completion: 0.7, // Replace with actual completion value
                  tasksLeft: 5, // Replace with actual tasks left
                );
              },
            ),
          ),
        ],
      ),
      
    );
  }
}

class StaffProgress extends StatelessWidget {
  final String name;
  final double completion;
  final int tasksLeft;

  StaffProgress({required this.name, required this.completion, required this.tasksLeft});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 18)),
                Text('Completion: ${(completion * 100).toInt()}%'),
                Text('Tasks left: $tasksLeft'),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: 1-completion,
              backgroundColor: Colors.black,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              strokeWidth: 6,
            ),
          ),
        ],
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
                  icon: Icon(Icons.bar_chart, size: 40)),
              BottomNavigationBarItem(
                  label: 'Person', icon: Icon(Icons.person_rounded, size: 40)),
            ],
          )));
}

