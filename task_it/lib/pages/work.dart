import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:hive/hive.dart";
import "package:task_it/pages/admin_home.dart";
import "package:task_it/pages/worker_tile.dart";
import "package:task_it/requirements/task.dart";
import "package:task_it/requirements/colors.dart";
import "package:task_it/requirements/database.dart";
import "package:task_it/requirements/dialog.dart";
import "package:task_it/requirements/tasktile.dart";

class Tasker extends StatefulWidget {
  const Tasker({super.key});

  @override
  State<Tasker> createState() => _TaskerState();
}

class _TaskerState extends State<Tasker> {
  final MyBox = Hive.box("my_box");
  ToDoDataBase db = ToDoDataBase();
  var _task_controller = TextEditingController();
  var _time_controller = TextEditingController();
  String _assigned_to = "";

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

 
  void createNewTask(Task task) {
    setState(() {
      db.toDoList.add(task);
    });
    db.updateDataBase();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index].isCompleted = !db.toDoList[index].isCompleted;
    });
    db.updateDataBase();
  }

  void deleteTask(Task task) {
    setState(() {
      db.toDoList.remove(task);
    });
    db.updateDataBase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
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
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: kWhite),
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
                ElevatedButton(
                  onPressed: () {
                  showDialog(
            context: context,
            builder: (context) => AddTaskDialog(onAddTask: createNewTask),
          );
                },
                  child: Text(
                    '+ Add Task',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                    deleteFunction: deleteTask,
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

