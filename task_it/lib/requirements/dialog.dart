import 'package:flutter/material.dart';
import 'package:task_it/requirements/task.dart';
import 'package:task_it/requirements/database.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(Task task) onAddTask;

  const AddTaskDialog({Key? key, required this.onAddTask}) : super(key: key);


  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  ToDoDataBase db = ToDoDataBase();
  String _selectedWorker = '';
  final _formKey = GlobalKey<FormState>();
  final task_controller = TextEditingController();
  final time_controller = TextEditingController();
  DateTime? _selectedDateTime;

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(picked),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          time_controller.text =
              "Date: ${picked.day}/${picked.month}/${picked.year} Time: ${pickedTime.hour}:${pickedTime.minute}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 229, 198, 234),
      title: Text('Add Task'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: task_controller,
              decoration: InputDecoration(labelText: 'Task Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a task title';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                      Icons.calendar_today), // Use an appropriate calendar icon
                  onPressed: () => _selectDateTime(context),
                ),
                Expanded(
                  child: TextFormField(
                    controller: time_controller,
                    decoration: InputDecoration(labelText: 'Task Deadline'),
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a task deadline';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            //Text(_selectedDateTime?.toString() ?? 'No deadline selected'),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Select Worker'),
              value: _selectedWorker.isEmpty ? null : _selectedWorker,
              items: db.workers.map((worker) {
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
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              task_controller.clear();
              time_controller.clear();
    });
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final task = Task(
                title: task_controller.text,
                deadline: time_controller.text,
                assigned_to: _selectedWorker,
              );
              widget.onAddTask(task);
              setState(() {
                task_controller.clear();
                time_controller.clear();
              });
              Navigator.of(context).pop();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
