import 'dart:ui';

import 'package:hive_flutter/hive_flutter.dart';

class Task {
  String task;
  DateTime time;
  String assigned_to;
  

  Task({
    required this.task,
    required this.time,
    required this.assigned_to,
    
  });
}