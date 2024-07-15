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
          title: Text('Work Progress'),
          backgroundColor: Colors.blue,
        ),
        body: WorkProgressScreen(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), // Added the Stats icon
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
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
            child: Column(
              children: [
                CircularProgressIndicator(
                  value: 0.55,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                SizedBox(height: 8),
                Text('55%', style: TextStyle(fontSize: 24, color: Colors.blue)),
                SizedBox(height: 16),
                Text('27 Tasks Left', style: TextStyle(fontSize: 18)),
                Text('34 Tasks Complete', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          SizedBox(height: 32),
          Text('Staff Progress', style: TextStyle(fontSize: 20)),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StaffProgress(name: 'SAMUEL KATO', completion: 0.52, tasksLeft: 12),
                  StaffProgress(name: 'LAMINE YAMAL', completion: 0.70, tasksLeft: 5),
                  StaffProgress(name: 'LIONEL MESSI', completion: 1.0, tasksLeft: 0),
                  StaffProgress(name: 'RUBEN DIAS', completion: 0.12, tasksLeft: 12),
                ],
              ),
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
          CircularProgressIndicator(
            value: completion,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}
