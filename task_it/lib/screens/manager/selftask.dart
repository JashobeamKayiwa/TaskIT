import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth for the logged-in user

enum FinanceType { Income, Expense }

class MyTask extends StatefulWidget {
  const MyTask({super.key});

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _timeController = TextEditingController();
  bool? _manualInput = false;
  FinanceType? _financeTypeEnum;

  final _categoryList = ['Work', 'Finance'];
  String? _categorySelected;

  @override
  void initState() {
    super.initState();
    _categorySelected = _categoryList[0]; // Set the initial selected value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFormField(
                  _titleController, "Title", Icons.info_outline_rounded),
              DropdownButtonFormField<String>(
                hint: Text("Category"),
                value: _categorySelected,
                focusColor: Colors.transparent,
                items: _categoryList
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _categorySelected = val;
                    if (_categorySelected != 'Finance') {
                      _manualInput = false;
                    }
                  });
                },
              ),
              CheckboxListTile(
                activeColor: kBlack,
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("Manual Input"),
                checkColor: kWhite,
                value: _manualInput,
                onChanged: _categorySelected == 'Finance'
                    ? (val) {
                        setState(() {
                          _manualInput = val;
                        });
                      }
                    : null,
              ),
              _buildTextFormField(
                  _amountController, "Amount", Icons.attach_money_outlined,
                  enabled: _categorySelected == 'Finance' && !_manualInput!),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<FinanceType>(
                      contentPadding: EdgeInsets.all(0.0),
                      value: FinanceType.Income,
                      activeColor: kBlack,
                      groupValue: _financeTypeEnum,
                      title: Text('Income'),
                      onChanged: _categorySelected == 'Finance'
                          ? (val) {
                              setState(() {
                                _financeTypeEnum = val;
                              });
                            }
                          : null,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<FinanceType>(
                      contentPadding: EdgeInsets.all(0.0),
                      value: FinanceType.Expense,
                      activeColor: kBlack,
                      groupValue: _financeTypeEnum,
                      title: Text('Expense'),
                      onChanged: _categorySelected == 'Finance'
                          ? (val) {
                              setState(() {
                                _financeTypeEnum = val;
                              });
                            }
                          : null,
                    ),
                  ),
                ],
              ),
              _buildTextFormField(_timeController, "Due Time", Icons.timer,
                  readOnly: true, onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _timeController.text = pickedTime.format(context);
                  });
                }
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel', style: TextStyle(color: kBlack)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kWhite,
                        padding: EdgeInsets.only(
                          right: 20.0,
                          left: 20.0,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      child: Text('Add Task', style: TextStyle(color: kWhite)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBlack,
                        padding: EdgeInsets.only(
                          right: 20.0,
                          left: 20.0,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String hintText, IconData icon,
      {bool enabled = true, bool readOnly = false, VoidCallback? onTap}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: enabled ? kGrey : kGrey.withOpacity(0.5),
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      enabled: enabled,
      readOnly: readOnly,
      onTap: onTap,
    );
  }

  void _submitForm() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user is logged in')));
      return;
    }

    if (_titleController.text.isEmpty ||
        _categorySelected == null ||
        (_categorySelected == 'Finance' &&
            !_manualInput! &&
            (_amountController.text.isEmpty || _financeTypeEnum == null))) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all the required fields')));
      return;
    }

    // Prepare task data
    Map<String, dynamic> taskData = {
      'title': _titleController.text,
      'category': _categorySelected,
      'worker': user.uid, // Assign to the logged-in user
      'manualInput': _categorySelected == 'Finance' ? _manualInput : null,
      'dueTime': _timeController.text,
      'createdAt': Timestamp.now(),
      'status': 'Pending', // Set initial status to 'Pending'
      'isPersonal': true, // Set isPersonal to true
    };

    if (_categorySelected == 'Finance') {
      taskData.addAll({
        'amount': _manualInput! ? null : _amountController.text,
        'financeType':
            _financeTypeEnum == FinanceType.Income ? 'Income' : 'Expense',
      });
    }

    try {
      // Submit to Firestore
      await FirebaseFirestore.instance.collection('tasks').add(taskData);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Task added successfully')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to add task: $e')));
    }
  }
}
