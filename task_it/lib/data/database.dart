import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  //hive box
  final MyBox = Hive.box("my_box");

  //first time ever opening app
  void createInitData() {
    toDoList = [
      //["Make tutorial", false],
      //["Do exercise", false],
    ];
  }

  // load data from database
  void loadData() {
    toDoList = MyBox.get("TODOLIST");
  }

  //upload to the database
  void updateDataBase() {
    MyBox.put("TODOLIST", toDoList);
  }
}
