import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

class Tiles extends StatelessWidget {
  final Icon leadingIcon;
  final String titleText;

  Tiles({required this.leadingIcon, required this.titleText});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.24),
            offset: Offset(0, 7),
            blurRadius: 10.0,
            spreadRadius: 0.0,
          )
        ]),
        child: Center(
            child: ListTile(
          onTap: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          tileColor: kGrey,
          leading: leadingIcon,
          title: Text(titleText,
              style: TextStyle(
                  fontSize: 40, color: kBlack, fontWeight: FontWeight.bold)),
          trailing: Icon(Icons.arrow_right, size: 50),
        )));
  }
}
