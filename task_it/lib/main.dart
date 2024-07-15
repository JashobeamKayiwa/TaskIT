import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Work Progress', style: TextStyle(fontWeight: FontWeight.bold),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body:Column(
        children: [
          Divider(height: 1, color: Colors.grey), 
          Expanded(
          child: WorkProgressScreen(),),
          ],),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 28),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
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


