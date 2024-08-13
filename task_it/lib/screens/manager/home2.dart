import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/profile/profile.dart';
import 'package:task_it/screens/worker/worker_home.dart';

class Home2 extends StatefulWidget {
  const Home2({super.key});

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
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
         WorkerHome(),
         UserProfile(
          userId: '', // Provide an empty string or handle it accordingly.
        ),
      ];
    }
    return [
      WorkerHome(),
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


