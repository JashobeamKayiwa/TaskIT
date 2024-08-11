import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_it/constants/colors.dart';

enum FinanceType { Income, Expense }

class EditTask extends StatefulWidget {
  final DocumentSnapshot? task;

  const EditTask({super.key, this.task});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _timeController = TextEditingController();
  bool _manualInput = false; // Initialize as false
  FinanceType? _financeTypeEnum;

  final _categoryList = ['Work', 'Finance'];
  String? _categorySelected;

  List<String> _workerList = [];
  String? _workerSelected;

  @override
  void initState() {
    super.initState();
    _categorySelected = _categoryList[0]; // Set the initial selected value
    _fetchWorkers(); // Fetch worker list from the database

    if (widget.task != null) {
      _initializeFormFields(widget.task!);
    }
  }

  Future<void> _fetchWorkers() async {
    // Fetch the list of workers from the database
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Worker')
        .get();
    setState(() {
      _workerList = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  void _initializeFormFields(DocumentSnapshot task) {
    _titleController.text = task['title'];
    _categorySelected = task['category'];
    _workerSelected = task['worker'];
    _manualInput = task['manualInput'] ?? false; // Handle potential null value
    _timeController.text = task['dueTime'];

    if (_categorySelected == 'Finance') {
      _amountController.text = task['amount'] ?? '';
      _financeTypeEnum = task['financeType'] == 'Income'
          ? FinanceType.Income
          : FinanceType.Expense;
    }
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
              DropdownButtonFormField<String>(
                hint: Text("Assign Worker"),
                value: _workerSelected,
                focusColor: Colors.transparent,
                items: _workerList
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _workerSelected = val;
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
                          _manualInput = val!;
                        });
                      }
                    : null,
              ),
              _buildTextFormField(
                  _amountController, "Amount", Icons.attach_money_outlined,
                  enabled: _categorySelected == 'Finance' && !_manualInput),
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
                      child: Text(
                          widget.task == null ? 'Add Task' : 'Update Task',
                          style: TextStyle(color: kWhite)),
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
    if (_titleController.text.isEmpty ||
        _categorySelected == null ||
        _workerSelected == null ||
        (_categorySelected == 'Finance' &&
            !_manualInput &&
            (_amountController.text.isEmpty || _financeTypeEnum == null))) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all the required fields')));
      return;
    }

    // Prepare task data
    Map<String, dynamic> taskData = {
      'title': _titleController.text,
      'category': _categorySelected,
      'worker': _workerSelected,
      'manualInput': _categorySelected == 'Finance' ? _manualInput : null,
      'dueTime': _timeController.text,
      'createdAt': Timestamp.now(),
      'status': 'Pending', // Set initial status to 'Pending'
      'isPersonal': false, // Set isPersonal to false
    };

    if (_categorySelected == 'Finance') {
      taskData.addAll({
        'amount': _manualInput ? null : _amountController.text,
        'financeType':
            _financeTypeEnum == FinanceType.Income ? 'Income' : 'Expense',
      });
    }

    try {
      if (widget.task == null) {
        // Add new task
        await FirebaseFirestore.instance.collection('tasks').add(taskData);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Task added successfully')));
      } else {
        // Update existing task
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(widget.task!.id)
            .update(taskData);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Task updated successfully')));
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to submit task: $e')));
    }
  }
}