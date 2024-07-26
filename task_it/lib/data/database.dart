import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  List Personal = [["dig","2",false,"job"],];

  //hive box
  final MyBox = Hive.box("my_box");

  //first time ever opening app
  void createInitData() {
    toDoList = [
      //["Make tutorial", false],
      //["Do exercise", false],
    ];
    Personal = [];
  }

  // load data from database
  void loadData() {
    toDoList = MyBox.get("TODOLIST");
    Personal = MyBox.get("PERSONAL");
  }

  //upload to the database
  void updateDataBase() {
    MyBox.put("TODOLIST", toDoList);
    MyBox.put("PERSONAL", Personal);
  }
}
