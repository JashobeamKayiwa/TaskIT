import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_it/pages/add_task.dart';
import 'package:task_it/pages/admin_home.dart';
import 'package:task_it/pages/admin_work.dart';
import 'package:task_it/pages/home.dart';
import 'package:task_it/pages/home.dart';
import 'package:flutter/services.dart';
import 'package:task_it/pages/personal.dart';
import 'package:task_it/pages/tasker.dart';
import 'package:task_it/pages/worker_tile.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("my_box");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskIT',
      home: Home(),
      routes: {
      "/home": (context) => Home(),
      "/admin_work": (context) => AdminWork(),
      "/admin_home": (context) => AdminHome(),
      //"/login": (context) => ,
      "/worker_tile": (context) => WorkerTile(),
      "tasker": (context) => Tasker(),

      },
    );
  }
}
