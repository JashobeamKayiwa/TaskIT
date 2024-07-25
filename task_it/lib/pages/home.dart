import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_it/data/database.dart';
import 'package:task_it/pages/add_task.dart';
import 'package:task_it/pages/admin_home.dart';
import 'package:task_it/pages/admin_work.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/pages/personal.dart';
import 'package:task_it/pages/tasker.dart';
import 'package:task_it/pages/worker_tile.dart';
import 'package:task_it/widgets/tiles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //hive box
  final MyBox = Hive.box("my_box");
  ToDoDataBase db = ToDoDataBase();

  int selectedindex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  List pages = [
    AdminHome(),
    //Statistics(),
    //Profile(),
  ];

  @override
  void initState() {
    //first time opening the app
    if (MyBox.get("TODOLIST") == null) {
      if (MyBox.get("PERSONAL") == null) {
        db.createInitData();
      }
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

  //text controllers
  var _task_controller = TextEditingController();
  var _time_controller = TextEditingController();
  String _assigned_to = "None";

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][2] = !db.toDoList[index][2];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_task_controller.text, _time_controller.text, false, _assigned_to]);
      _task_controller.clear();
      _time_controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //cancel new task
  void cancelNewTask() {
    setState(() {
      _task_controller.clear();
      _time_controller.clear();
    });
    Navigator.of(context).pop();
  }

  //create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTask(
            task_controller: _task_controller,
            time_controller: _time_controller,
            assigned_to: _assigned_to,
            on_save: saveNewTask,
            on_cancel: cancelNewTask);
      },
    );
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedindex],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: createNewTask,
      //   child: Icon(Icons.add),
      //   backgroundColor: Colors.yellow,
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   currentIndex: selectedindex,
      //   onTap: navigateBottomBar,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home, size: 28),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.bar_chart, size: 28),
      //       label: 'Stats',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person, size: 28),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
