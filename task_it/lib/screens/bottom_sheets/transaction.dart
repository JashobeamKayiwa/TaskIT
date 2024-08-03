import 'package:flutter/material.dart';
import 'package:task_it/screens/bottom_sheets/google_sheets.dart';

class MyTransaction extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;

  const MyTransaction({
    super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
  });

  @override
  Widget build(BuildContext context) {
    final String balance = (GoogleSheetsApi.calculateIncome() -
                      GoogleSheetsApi.calculateExpense())
                  .toString();
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
                  SizedBox(
                    width: 16,
                  ),
                  Text(transactionName),
                ],
              ),
              Column(
                children: [
                  Text(
                    expenseOrIncome == 'expense' ? '-' + 'Shs.' + money : '+' + 'Shs.' + money,
                    style: TextStyle(
                      color: (expenseOrIncome == 'expense'
                          ? Colors.red
                          : Colors.green),
                    ),
                  ),
                  Text(
                'Shs. ${balance}',
                style: TextStyle(color: Colors.grey,),
              ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
