import 'package:flutter/material.dart';
import 'package:task_it/data/database.dart';
import 'package:task_it/data/task.dart';

class AddTaskWork extends StatefulWidget {
  const AddTaskWork({super.key});

  @override
  State<AddTaskWork> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskWork> {
  ToDoDataBase db = ToDoDataBase();
  String _selectedWorker = '';
  final List<String> _workers = ['Alice', 'Bob', 'Charlie'];
  final task_controller = TextEditingController();
  final time_controller = TextEditingController();
  DateTime? combinedDateTime;

  Future<void> _showDateTimePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:
          DateTime.now().add(Duration(days: 365)), // Limit to one year from now
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        time_controller.text = '${selectedTime.hour}:${selectedTime.minute}';
        // Use `combinedDateTime` for your task time
      }
    }
  }

  void createNewTask() {
    final task = Task(
      task: task_controller.text,
      time: combinedDateTime!,
      assigned_to: _selectedWorker,
    );
    setState(() {
      db.toDoList.add([task_controller.text, "${time_controller.text}", false, _selectedWorker]);
    });
    task_controller.clear();
    time_controller.clear();
    db.updateDataBase();
    Navigator.of(context).pop;
  }

  void cancelNewTask() {
    task_controller.clear();
    time_controller.clear();
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 300,
          height: 400,
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
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons
                        .calendar_today), // Use an appropriate calendar icon
                    onPressed: () {
                      // Show date and time picker dialog
                      _showDateTimePicker(context);
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: time_controller,
                      decoration: InputDecoration(
                        hintText: 'Time',
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Assign to Worker'),
                value: _selectedWorker.isEmpty ? null : _selectedWorker,
                items: _workers.map((worker) {
                  return DropdownMenuItem<String>(
                    value: worker,
                    child: Text(worker),
                  );
                }).toList(),
                onChanged: (newValue) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a worker';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: cancelNewTask,
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
                    onPressed: createNewTask,
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
