import 'package:expensetracker/screens/add_expense/views/add_expense.dart';
import 'package:expensetracker/screens/home/views/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expensetracker/screens/stats/stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int index = 0;
  late Color selectedItem=Colors.blueAccent;
  //Color unselectedItem = Colors.black;
                                           //changing screens
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
        //selectedItemColor: Colors.blue,
        //nselectedItemColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 250, 249, 249),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 6,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),
          //color : index == 0 ? selectedItem : unselectedItem,                             color for selected icon 
          label: 'Home',
          ),
          // BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_grid_2x2),
          // label: 'Categories',
          // ),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar),
          label: 'Reports',
          ),
         
          
        ],
      ), 
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddExpense()
              )
            );
        },
        shape:const CircleBorder(),
        child:Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
           gradient:LinearGradient(
            colors:[
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
           ],
           transform: const GradientRotation(pi / 4),
           )
          ),
          child: const Icon(
            CupertinoIcons.add),
          ),
      ),

      body: index == 0
      ? const MainScreen()
      :const StatScreen(),
      //backgroundColor:Colors.black12 ,
      );
  }
}