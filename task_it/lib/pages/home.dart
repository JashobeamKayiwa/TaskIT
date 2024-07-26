import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_it/data/database.dart';
import 'package:task_it/pages/add_task_personal.dart';
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
