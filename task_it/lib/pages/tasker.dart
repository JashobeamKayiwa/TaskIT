import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:hive/hive.dart";
import "package:task_it/constants/colors.dart";
import "package:task_it/data/database.dart";
import "package:task_it/pages/add_task.dart";
import "package:task_it/pages/admin_home.dart";

class Tasker extends StatefulWidget {
  const Tasker({super.key});

  @override
  State<Tasker> createState() => _TaskerState();
}

class _TaskerState extends State<Tasker> {
  final MyBox = Hive.box("my_box");
  ToDoDataBase db = ToDoDataBase();
  var _task_controller = TextEditingController();
  var _time_controller = TextEditingController();
  
  @override

  void createNewTask() {
      showDialog(
        context: context,
        builder: (context) {
          return AddTask(
            task_controller: _task_controller,
            time_controller: _time_controller,
            on_save: saveNewTask,
            on_cancel: cancelNewTask,);
      },
    );
  }

    void saveNewTask() {
      setState(() {
        db.toDoList.add([_task_controller.text, _time_controller.text, false]);
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

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][2] = !db.toDoList[index][2];
    });
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }


  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlack,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Material(
            elevation: 0,
            child: ClipRRect(
              child: AppBar(
                backgroundColor: kBlack,
                elevation: 0,
                leading: IconButton(
                icon: Icon(Icons.arrow_back, color: kWhite, ),
                onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminHome()));
                  },
                ),
                title: Row(
                  children: [
                    Text(
                      'WORK',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: kWhite),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: createNewTask,
                    child: Text('+ Add Task',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: kWhite,
                    ),
                  ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                    ),),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
              child: ListView.builder(
                itemCount: db.toDoList.length,
                itemBuilder: (context, index) {
                  return ToDoTile(
                    taskName: db.toDoList[index][0],
                    taskTime: db.toDoList[index][1],
                    taskCompleted: db.toDoList[index][2],
                    onChanged: (value) => checkBoxChanged(value, index),
                    deleteFunction: (context) => deleteTask(index),
                  );
                },
              ),
            )
            ],
          ),
        ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      );
  }
}

Widget _buildBottomNavigationBar() {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            )
          ]),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: kBlack,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            items: [
              BottomNavigationBarItem(
                  label: 'Home', icon: Icon(Icons.home_rounded, size: 40)),
              BottomNavigationBarItem(
                  label: 'Finances',
                  icon: Icon(Icons.bar_chart, size: 40)),
              BottomNavigationBarItem(
                  label: 'Person', icon: Icon(Icons.person_rounded, size: 40)),
            ],
          )));
}

class ToDoTile extends StatelessWidget {
  final String taskName;
  final String taskTime;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskTime,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25.0,
        top: 25.0,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(
            children: [
              //checkout
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              //task name
              Column(
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    taskTime,
                    style: TextStyle(
                      decoration: taskCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 195, 206, 208),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
