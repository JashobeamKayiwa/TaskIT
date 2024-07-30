import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_it/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_it/screens/addtask.dart';
import 'package:task_it/screens/forgot.dart';
import 'package:task_it/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskIT',
      home: LoginPage(),
    );
  }
}
