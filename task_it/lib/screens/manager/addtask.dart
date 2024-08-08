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