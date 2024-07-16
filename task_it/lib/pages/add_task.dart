import 'package:flutter/material.dart';

class AddTask extends StatelessWidget {
  final task_controller;
  final time_controller;
  VoidCallback on_save;
  VoidCallback on_cancel;

  AddTask({
    super.key,
    required this.task_controller,
    required this.time_controller,
    required this.on_save,
    required this.on_cancel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 229, 198, 234),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 16),
              TextField(
                controller: task_controller,
                decoration: InputDecoration(
                  hintText: 'Enter Task Description..',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: time_controller,
                decoration: InputDecoration(
                  hintText: 'Time',
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: on_cancel,
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: on_save,
                    child: Text(
                      '+ Add',
                      style: TextStyle(color: Colors.white),
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
            ],
          ),
        ),
      ),
    );
  }
}
