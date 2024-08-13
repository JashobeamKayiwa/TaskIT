import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

class Tiles extends StatelessWidget {
  final Icon leadingIcon;
  final String titleText;
  final double textSize; // New parameter for text size
  final VoidCallback onTap;

  Tiles({
    required this.leadingIcon,
    required this.titleText,
    required this.textSize, // Include textSize in the constructor
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.24),
            offset: Offset(0, 7),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: Center(
        child: ListTile(
          onTap: onTap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: kGrey,
          leading: leadingIcon,
          title: Text(
            titleText,
            style: TextStyle(
              fontSize: textSize, // Use the passed text size
              color: kBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(Icons.arrow_right, size: 50),
        ),
      ),
    );
  }
}
