import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

enum FinanceType { Income, Expense }

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _fNameController = TextEditingController();
  bool? _checkBox = false;
  FinanceType? _financeTypeEnum;

  final _categoryList = ['Work', 'Finance'];
  String? _categorySelected;

  final _workerList = [
    'Worker 1',
    'Worker 2',
    'Worker 3',
    'Worker 4',
    'Worker 5'
  ];
  String? _workerSelected;

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFormField(
                _fNameController, "Title", Icons.info_outline_rounded),
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
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _workerSelected,
              hint: Text("Worker"),
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
              value: _checkBox,
              onChanged: (val) {
                setState(() {
                  _checkBox = val;
                });
              },
            ),
            _buildTextFormField(
                _fNameController, "Amount", Icons.attach_money_outlined),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<FinanceType>(
                    contentPadding: EdgeInsets.all(0.0),
                    value: FinanceType.Income,
                    activeColor: kBlack,
                    groupValue: _financeTypeEnum,
                    title: Text('Income'),
                    onChanged: (val) {
                      setState(() {
                        _financeTypeEnum = val;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<FinanceType>(
                    contentPadding: EdgeInsets.all(0.0),
                    value: FinanceType.Expense,
                    activeColor: kBlack,
                    groupValue: _financeTypeEnum,
                    title: Text('Expense'),
                    onChanged: (val) {
                      setState(() {
                        _financeTypeEnum = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {},
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
                    onPressed: () {},
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
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String hintText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: kGrey,
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }
}
