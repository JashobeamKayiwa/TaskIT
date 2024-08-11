

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:task_it/constants/Texttheme.dart';
import 'package:task_it/constants/colors.dart';

//import 'colors.dart';

class TAppTheme {
  TAppTheme ();

static ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  //textTheme: TTextTheme.lightTextTheme, 
  // outlinedButtonTheme: OutlinedButtonTheme.lightOutlinedButtonTheme,
  // elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
  // inputDecorationTheme: TTextFormFieildTheme.lightinputDecorationTheme,
  //darkTheme: TAppTheme.darkTheme,
  //theme: TAppTheme.lightTheme,
);
static ThemeData darkTheme = ThemeData(
  brightness: Brightness.light,
  //textTheme: TTextTheme.darkTextTheme,
  // outlinedButtonTheme: OutlinedButtonTheme.darkOutlinedButtonTheme,
  // elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
  // inputDecorationTheme: TTextFormFieildTheme.darkinputDecorationTheme,  
);
}


class TTextTheme {
}


  