import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

class RegButton extends StatelessWidget {
  const RegButton({
    Key? key,
    required this.onPress,
  }) : super(key: key);

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        child: Text('Sign In', style: TextStyle(color: kWhite)),
        style: ElevatedButton.styleFrom(
          backgroundColor: kBlack,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ));
  }
}

