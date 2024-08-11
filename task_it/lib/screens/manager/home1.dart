//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/screens/manager/home.dart';
import 'package:task_it/profile/profile.dart';
import 'package:task_it/screens/manager/statistics.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  int selectedindex = 0;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
  }

  void navigateBottomBar(int index) {
    setState(() {
      selectedindex = index;
    });
  }

  List<Widget> get pages {
    if (user == null) {
      return [
         HomePage(),
         Statistics(),
         UserProfile(
          userId: '', // Provide an empty string or handle it accordingly.
        ),
      ];
    }
    return [
      const HomePage(),
      const Statistics(),
      UserProfile(
        userId: user!.uid, // Safe to access `uid` since `user` is non-null.
      ),
    ];
  }

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
            ),
          ],
        ),
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
            currentIndex: selectedindex, // Keep track of the current index.
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_rounded, size: 40),
              ),
              BottomNavigationBarItem(
                label: 'Finances',
                icon: Icon(Icons.bar_chart, size: 40),
              ),
              BottomNavigationBarItem(
                label: 'Person',
                icon: Icon(Icons.person_rounded, size: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


