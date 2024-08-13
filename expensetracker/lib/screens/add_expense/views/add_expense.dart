import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpense extends StatefulWidget {
  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  IconData? selectedIcon; // Changed to IconData to use Ionicons
  bool isExpanded = false;
  Color selectedColor = Colors.white; // Default color

  // Define the list of icons
  final List<IconData> icons = [
    Ionicons.wallet,
    Ionicons.cash,
    Ionicons.card,
  ];

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: expenseController,
              decoration: InputDecoration(labelText: 'Expense'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: dateController,
              decoration: InputDecoration(labelText: 'Date'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  setState(() {
                    selectedDate = pickedDate;
                    dateController.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButton<IconData>(
              value: selectedIcon,
              hint: Text('Select Icon'),
              items: icons.map((icon) {
                return DropdownMenuItem<IconData>(
                  value: icon,
                  child: Row(
                    children: [
                      Icon(icon),
                      const SizedBox(width: 8),
                      Text(icon
                          .toString()), // You can replace this with a more descriptive name if available
                    ],
                  ),
                );
              }).toList(),
              onChanged: (IconData? newIcon) {
                setState(() {
                  selectedIcon = newIcon;
                });
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                // Logic to pick a color
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Pick a Color'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ColorPicker(
                            pickerColor: selectedColor,
                            onColorChanged: (color) {
                              setState(() {
                                selectedColor = color;
                              });
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    color: selectedColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Select Color'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Save expense data directly
                await FirebaseFirestore.instance.collection('expenses').add({
                  'amount': double.parse(expenseController.text),
                  'category': categoryController.text,
                  'date': selectedDate,
                  'icon': {
                    'codePoint': selectedIcon!.codePoint,
                    'fontFamily': selectedIcon!.fontFamily,
                  },
                  'color': selectedColor.value,
                });
                Navigator.of(context).pop();
              },
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}

