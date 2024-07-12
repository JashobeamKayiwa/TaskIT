import 'package:task_it/screens/expense_home/views/expense_main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_it/screens/stats/stats.dart';

import 'package:task_it/workers_screens/home_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

 var widgetlist = [
  MainScreen(),
  StatsScreen(),
  WorkersProfileScreen()

 ];

 int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Expense Tracker'),

      // ),
      
      bottomNavigationBar: ClipRRect(
        borderRadius:const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        
        
       child:  BottomNavigationBar(
        onTap: (value) => 
        setState(() {
          index = value;                                   //changing through the tabs
        }
        ),
        fixedColor: Colors.blueAccent,
        backgroundColor: const Color.fromARGB(255, 250, 249, 249),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 6,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
                              
          label: 'Home',
          ),
          
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar),
          label: 'Stats',
          ),
         
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled),
          label: 'Profile',
          ),
         
          
        ],
      ), 
      ),
      
      
      
     body: (index == 0)
  ? MainScreen()
  : (index == 1)
    ? StatsScreen()
    : WorkersProfileScreen()
  );
  }
}