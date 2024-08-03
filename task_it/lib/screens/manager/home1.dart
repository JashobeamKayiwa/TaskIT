import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/screens/manager/home.dart';
import 'package:task_it/screens/manager/statistics.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int selectedindex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  List pages = [
    HomePage(),
    Statistics(),
    //Profile(),
  ];

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[selectedindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
              )
            ]),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedItemColor: kBlack,
              unselectedItemColor: Colors.grey.withOpacity(0.5),
              onTap: navigateBottomBar,
              items: const [
                BottomNavigationBarItem(
                    label: 'Home', icon: Icon(Icons.home_rounded, size: 40)),
                BottomNavigationBarItem(
                    label: 'Finances', icon: Icon(Icons.bar_chart, size: 40)),
                BottomNavigationBarItem(
                    label: 'Person',
                    icon: Icon(Icons.person_rounded, size: 40)),
              ],
            ))),
    );
  }
}