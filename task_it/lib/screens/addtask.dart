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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFormField(
                  _fNameController, "First Name", Icons.person_outline_sharp),
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
            ],
          ),
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
