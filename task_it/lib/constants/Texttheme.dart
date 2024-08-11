// import 'package:flutter/material.dart';
// import 'package:task_it/constants/colors.dart';

// class TAppTheme {
//   static ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     textTheme: Colors.black,
//   )
// }

import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

class TTextFormFieildTheme {
  TTextFormFieildTheme ();

static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
  prefixIconColor: kBlue,
  floatingLabelStyle:  TextStyle(color: Colors.white),
  focusedBorder:  OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Colors.white)
  )
);

static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
  prefixIconColor: kBlue,
  floatingLabelStyle:  TextStyle(color: kBlack),
  focusedBorder:  OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: kBlack)
  )
);
}


class TElevatedButtonTheme {
  TElevatedButtonTheme ();

static InputDecorationTheme darkElevatedButtonTheme = InputDecorationTheme(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
  prefixIconColor: kBlue,
  floatingLabelStyle:  TextStyle(color: Colors.white),
  focusedBorder:  OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Colors.white)
  )
);
}
