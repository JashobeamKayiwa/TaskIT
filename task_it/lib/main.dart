import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_it/pages/add_task.dart';
import 'package:task_it/pages/admin_work.dart';
import 'package:task_it/pages/home.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("my_box");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      //routes: {
      //"/home": (context) => Home(),
      //"/admin_work": (context) => AdminWork(),
      //"/add_task": (context) => AddTask(),
      //},
    );
  }
}
