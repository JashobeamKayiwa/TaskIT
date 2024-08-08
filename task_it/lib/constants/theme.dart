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

class TTextFormFieldTheme {
  TTextFormFieldTheme ();

static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
  prefixIconColor: kBlue,
  floatingLabelStyle: const TextStyle(color: Colors.white),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: Colors.white)
  )
);

static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
  prefixIconColor: kBlue,
  floatingLabelStyle: const TextStyle(color: kBlack),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(width: 2, color: kBlack)
  )
);
}

class TAppTheme {
  TAppTheme ();

static ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  //textTheme: TTextFormFieldTheme.lightTextTheme,  
);
static ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  //textTheme: TTextFormFieldTheme.darkTextTheme,  
);
}