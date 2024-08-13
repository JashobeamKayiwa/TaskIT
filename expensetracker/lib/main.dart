import 'package:flutter/material.dart';
import 'package:expensetracker/app.dart';
import 'package:expensetracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  async {
   await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
