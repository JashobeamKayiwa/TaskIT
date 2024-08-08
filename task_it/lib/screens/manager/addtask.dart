import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum FinanceType { Income, Expense }

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _timeController = TextEditingController();
  bool? _manualInput = false;
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