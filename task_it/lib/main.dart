import 'package:flutter/material.dart';
import 'package:task_it/pages/add_task.dart';
import 'package:task_it/pages/admin_work.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminWork(),
      routes: {
        "/admin_work": (context) => AdminWork(),
        "/add_task": (context) => AddTask(),
      },
    );
  }
}

