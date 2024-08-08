import 'package:flutter/material.dart';

class MyTransaction extends StatefulWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;
  final Function(bool, double, String, int) onCheckboxChanged;
  final int rowIndex;
  final bool initialIsChecked; // Add this

  const MyTransaction({
    super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
    required this.onCheckboxChanged,
    required this.rowIndex,
    required this.initialIsChecked, // Add this
  });

  @override
  _MyTransactionState createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  late bool isChecked; // Use late modifier

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialIsChecked; // Initialize state
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isChecked = value ?? false;
    });

    final amount = double.parse(widget.money);
    widget.onCheckboxChanged(isChecked, amount, widget.expenseOrIncome, widget.rowIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: EdgeInsets.all(15),
          color: Colors.grey[100],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[500],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(widget.transactionName),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.expenseOrIncome == 'expense'
                        ? '-' + 'Shs.' + widget.money
                        : '+' + 'Shs.' + widget.money,
                    style: TextStyle(
                      color: (widget.expenseOrIncome == 'expense'
                          ? Colors.red
                          : Colors.green),
                    ),
                  ),
                  Checkbox(
                    value: isChecked,
                    onChanged: _onCheckboxChanged,
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
