import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/screens/finance/tracker.dart';
import 'package:task_it/screens/manager/personal.dart';
import 'package:task_it/screens/manager/tasker.dart';
import 'package:task_it/widgets/tiles.dart'; // Add GetX if needed for state management

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userName = userDoc['name'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textSize =
        screenWidth * 0.05; // Adjust text size relative to screen width

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: _buildAppBar(screenWidth),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.05,
                bottom: screenHeight * 0.02,
              ),
              child: const Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Tiles(
                    leadingIcon: const Icon(
                      Icons.account_circle_sharp,
                      size: 60,
                      color: kBlack,
                    ),
                    titleText: 'Personal',
                    textSize: textSize, // Pass calculated text size
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Personal(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Tiles(
                    leadingIcon: const Icon(
                      Icons.work,
                      size: 60,
                      color: kBlack,
                    ),
                    titleText: 'Work',
                    textSize: textSize, // Pass calculated text size
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Tasker(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Tiles(
                    leadingIcon: const Icon(
                      Icons.bar_chart,
                      size: 60,
                      color: kBlack,
                    ),
                    titleText: 'Finance',
                    textSize: textSize, // Pass calculated text size
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackerPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(screenHeight),
    );
  }

  Widget _buildAppBar(double screenWidth) {
    return Material(
      elevation: 5,
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'Welcome, $userName',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.065,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: const [
            Icon(Icons.add_alert_rounded, color: Colors.black, size: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(double screenHeight) {
    return Container(
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
    );
  }
}
