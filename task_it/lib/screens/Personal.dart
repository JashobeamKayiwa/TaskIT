import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_it/screens/addtask.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white),
    );
    return MaterialApp(
      theme: ThemeData(           
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          ),
        ),
      debugShowCheckedModeBanner: false,
      home: TaskScreen(),
    );
  }
}

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
   List<bool> _isCheckedPersonal = List<bool>.filled(3, false);
   List<Task> _tasksPersonal = ([
     Task(text: 'Hatchery Maintenance', date: '15 Jun at 4:30pm', completed: false),
     Task(text: 'Feed the chickens', date: '16 Jun at 10:00am', completed: false),
     Task(text: 'Collect eggs', date: '16 Jun at 2:00pm', completed: false),
  ]);
  List<Task> _tasksToday = [];
  List<bool> _isCheckedToday = [];
 
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Color.fromARGB(255, 117, 115, 115).withOpacity(0.1)), // Change overlay color
            splashFactory: NoSplash.splashFactory, // Remove splash effect
          ),
          ),
          title: Text('Personal', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.black),
              onPressed: () async {
                // Navigate to CreateTaskPage and get the new task (if added)
                final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddTask()),
                );
                if (newTask != null) {
                  setState(() {
                    _tasksPersonal.add(newTask);
                    _isCheckedPersonal.add(false);
                  });
                }
              },
              style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Color.fromARGB(255, 117, 115, 115).withOpacity(0.1).withOpacity(0.1)), // Change overlay color
              splashFactory: NoSplash.splashFactory, // Remove splash effect
            ),
          ),
            Icon(Icons.arrow_drop_down, color: Colors.black),
          ],
          bottom: TabBar(
            tabs: [
              Tab(child: Text('Tasks', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black))),
              Tab(child: Text('Today', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black))),
            ],
            overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.grey.withOpacity(0.1); // Change hover color
              }
              if (states.contains(WidgetState.pressed)) {
                return Colors.grey.withOpacity(0.2); // Change pressed color
              }
              return null; // Default color
            },
          ),
          ),
        ),
        body: TabBarView(
          children: [
            TaskList(
              tasks: _tasksPersonal,
              isChecked: _isCheckedPersonal,
              onDelete: _deleteTaskPersonal,
              onToggle: _toggleCheckboxPersonal,
              showDeleteIcon: false,
            ),
            TaskList(
              tasks: _tasksToday,
              isChecked: _isCheckedToday,
              onDelete: _deleteTaskToday,
              onToggle: _toggleCheckboxToday,
              showDeleteIcon: true,
            ),
          ],
        ),
      ),
    );
  }

  void _deleteTaskPersonal(int index) {
    setState(() {
      _tasksPersonal.removeAt(index);
      _isCheckedPersonal.removeAt(index);
    });
  }

  void _deleteTaskToday(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm'),
          content: Text('Are you sure you wish to remove this item?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _tasksToday.removeAt(index);
                  _isCheckedToday.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: Text('REMOVE'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCEL'),
            ),
          ],
        );
      },
    );
  }

   void _toggleCheckboxPersonal(int index, bool? value) {
    setState(() {
      _isCheckedPersonal[index] = value!;
      if (value!) {
        _tasksToday.add(_tasksPersonal[index]);
        _isCheckedToday.add(false);
        _tasksPersonal.removeAt(index);
        _isCheckedPersonal.removeAt(index);
      }
    });
  }

 void _toggleCheckboxToday(int index, bool? value) {
    setState(() {
      _isCheckedToday[index] = value!;
    });
  }
}
class Task {
  final String text;
  final String date;
  bool completed;

  Task({required this.text, 
  required this.date, 
  required this.completed});
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final List<bool> isChecked;
  final Function(int) onDelete;
  final Function(int, bool?) onToggle;
  final bool showDeleteIcon;

  TaskList({required this.tasks, 
  required this.isChecked, 
  required this.onDelete, 
  required this.onToggle, 
  required this.showDeleteIcon,
  });

  @override
  Widget build(BuildContext context) {
    return 
    tasks.isEmpty
        ? Center(child: Text('No tasks available', style: TextStyle(color: Colors.white)))
        : 
        ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: isChecked[index],
                  onChanged: (bool? value) {
                    onToggle(index, value);
                  },
                  activeColor: Colors.white,
                  checkColor: Colors.black,
                ),
                title: Text(tasks[index].text),
                subtitle: Text(tasks[index].date),
                trailing: showDeleteIcon
                    ? IconButton(
                        icon: Icon(Icons.delete, color: const Color.fromARGB(255, 165, 11, 0)),
                        onPressed: () { onDelete(index); }
                      )
                    : null,
              );
            },
          );
  }
}
