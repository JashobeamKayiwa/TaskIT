import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum FinanceType { Income, Expense }

class UpdateTask extends StatefulWidget {
  final DocumentSnapshot task; // Accept the task data

  const UpdateTask({super.key, required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  late TextEditingController _timeController;
  bool? _manualInput;
  FinanceType? _financeTypeEnum;

  final _categoryList = ['Work', 'Finance'];
  String? _categorySelected;

  @override
  void initState() {
    super.initState();

    final taskData = widget.task.data() as Map<String, dynamic>;

    _titleController = TextEditingController(text: taskData['title'] ?? '');
    _amountController = TextEditingController(text: taskData['amount'] ?? '');
    _timeController = TextEditingController(text: taskData['dueTime'] ?? '');
    _manualInput = taskData['manualInput'] ?? false;
    _categorySelected = taskData['category'];
    _financeTypeEnum = taskData['financeType'] == 'Income'
        ? FinanceType.Income
        : FinanceType.Expense;
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
                      activeColor: kBlack,
                      title: Text("Income"),
                      value: FinanceType.Income,
                      groupValue: _financeTypeEnum,
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
                      activeColor: kBlack,
                      title: Text("Expense"),
                      value: FinanceType.Expense,
                      groupValue: _financeTypeEnum,
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
              _buildTextFormField(_timeController, "Due Time", Icons.timer),
              SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(widget.task.id)
                            .update({
                          'title': _titleController.text,
                          'amount': _amountController.text,
                          'dueTime': _timeController.text,
                          'manualInput': _manualInput,
                          'financeType': _financeTypeEnum == FinanceType.Income
                              ? 'Income'
                              : 'Expense',
                          'category': _categorySelected,
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBlack,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: Text(
                        "Update Task",
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: kWhite,
                          fontSize: 18,
                        ),
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

  TextFormField _buildTextFormField(
      TextEditingController controller, String hintText, IconData icon,
      {bool enabled = true}) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kBlack),
        ),
      ),
    );
  }
}
