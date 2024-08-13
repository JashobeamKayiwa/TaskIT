import 'package:flutter/material.dart';
import 'package:expensetracker/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Expense tracker',
      theme: ThemeData(
        colorScheme:const ColorScheme.light(
          surface:Color.fromARGB(255, 218, 213, 213),
          onSurface:Colors.black,
          primary: Color(0xFF00B2E7), 
          secondary: Color(0xFFE064F7),
          tertiary: Color(0xFFFF8D6C),
          outline: Colors.grey
        )
      ),
      home: const HomeScreen(),
    );
  }
}