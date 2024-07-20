import "package:flutter/material.dart";
import "package:task_it/constants/colors.dart";
import "package:task_it/data/database.dart";
import "package:task_it/pages/add_task.dart";
import "package:task_it/pages/admin_home.dart";

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
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
          on_cancel: cancelNewTask,
        );
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
                    'PERSONAL',
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
                  child: Text(
                    '+ Add Task',
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
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.crop_square),
                      isThreeLine: true,
                      title: Text('Win the World Cup',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Time: 20:22pm \n Lionel Messi'),
                      trailing: Icon(Icons.delete_outlined, color: kRedDark),
                    ),
                  ),
                ],
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
                  icon: Icon(Icons.attach_money_outlined, size: 40)),
              BottomNavigationBarItem(
                  label: 'Person', icon: Icon(Icons.person_rounded, size: 40)),
            ],
          )));
}
