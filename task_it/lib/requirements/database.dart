import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_it/requirements/task.dart';

class ToDoDataBase {
  List<Task> toDoList = [];
  List<Task> Personal = [];
  List<String> workers = ['Alice', 'Bob', 'Charlie'];

  //hive box
  final MyBox = Hive.box("my_box");

  //first time ever opening app
  void createInitData() {
    toDoList = [
      //["Make tutorial", false],
      //["Do exercise", false],
    ];
    Personal = [];
    workers = ['Alice', 'Bob', 'Charlie'];
  }

  // load data from database
  void loadData() {
    toDoList = MyBox.get("TODOLIST");
    Personal = MyBox.get("PERSONAL");
    workers = MyBox.get("WORKERS");
  }

  //upload to the database
  void updateDataBase() {
    MyBox.put("TODOLIST", toDoList);
    MyBox.put("PERSONAL", Personal);
    MyBox.put("WORKERS", workers);
  }
}
