import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_it/requirements/task.dart';

class ToDoDataBase {

  List<String> workers = ['Alice', 'Bob', 'Charlie'];

  //hive box
  final MyBox = Hive.box("my_box");

  //first time ever opening app
  void createInitData() {
    
    workers = ['Alice', 'Bob', 'Charlie'];
  }

  // load data from database
  void loadData() {
    
    workers = MyBox.get("WORKERS");
  }

  //upload to the database
  void updateDataBase() {
    
    MyBox.put("WORKERS", workers);
  }
}
