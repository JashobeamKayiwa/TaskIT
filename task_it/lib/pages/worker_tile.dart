import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:task_it/pages/admin_home.dart';
import 'package:task_it/requirements/colors.dart';
import 'package:task_it/requirements/database.dart';
import 'package:task_it/requirements/task.dart';
import 'package:task_it/requirements/tasktile.dart';

class WorkerTile extends StatefulWidget {
  const WorkerTile({super.key});

  @override
  State<WorkerTile> createState() => _WorkerTileState();
}

class _WorkerTileState extends State<WorkerTile> {
  final MyBox = Hive.box("my_box");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //first time opening the app
    if (MyBox.get("TODOLIST") == null) {
      db.createInitData();
    } else {
      //not first time
      db.loadData();
    }

    super.initState();
  }

  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index].isCompleted = !db.toDoList[index].isCompleted;
    });
    db.updateDataBase();
  }

  // void deleteTask(Task task) {
  //   setState(() {
  //     db.Personal.remove(task);
  //   });
  //   db.updateDataBase();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Material(
          elevation: 0,
          child: ClipRRect(
            child: AppBar(
              backgroundColor: kBlack,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: kWhite,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminHome()));
                },
              ),
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
            ),
          ),
        ),
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
                    Icon(Icons.circle_outlined, size: 90),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Tasks Remaining: 0',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: kBlack,
                      ),
                    ),
                    Text(
                      'Tasks Completed: 12',
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
            Row(
              children: [
                Icon(Icons.phone),
                SizedBox(width: 4),
                Text('+256 777101010'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    task: db.toDoList[index],
                    taskCompleted: db.toDoList[index].isCompleted,
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) => null,
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
                  label: 'Finances', icon: Icon(Icons.bar_chart, size: 40)),
              BottomNavigationBarItem(
                  label: 'Person', icon: Icon(Icons.person_rounded, size: 40)),
            ],
          )));
}

