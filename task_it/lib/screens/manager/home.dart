import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/profile/profile.dart';
import 'package:task_it/screens/manager/personal.dart';
import 'package:task_it/screens/manager/tasker.dart';
import 'package:task_it/screens/manager/worker_tile.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: _buildAppBar(),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 20),
                child: const Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Tiles(
                    leadingIcon: const Icon(Icons.account_circle_sharp,
                        size: 60, color: kBlack),
                    titleText: 'Personal',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Personal()));
                    },
                  ),
                  const SizedBox(height: 20),
                  Tiles(
                    leadingIcon:
                        const Icon(Icons.work, size: 60, color: kBlack),
                    titleText: 'Work',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tasker()));
                    },
                  ),
                  const SizedBox(height: 20),
                  Tiles(
                    leadingIcon:
                        const Icon(Icons.bar_chart, size: 60, color: kBlack),
                    titleText: 'Finance',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkerTile()));
                    },
                  ),
                ],
              ))
            ],
          )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildAppBar() {
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
              Text('Welcome, $userName',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          actions: const [
            Icon(Icons.add_alert_rounded, color: Colors.black, size: 40)
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
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
              items: const [
                BottomNavigationBarItem(
                    label: 'Home', icon: Icon(Icons.home_rounded, size: 40)),
                BottomNavigationBarItem(
                    label: 'Finances', icon: Icon(Icons.bar_chart, size: 40)),
                BottomNavigationBarItem(                         
                    icon: Icon(Icons.person_rounded, size: 40),
                    label: 'Person',
                    // onPressed: () { 
                    //         Navigator.of(context).push(
                    //           MaterialPageRoute(
                    //               builder: (context) => UserProfile(userId: userId),
                    //               ));
                    //       },
                    ),
              ],
            )));
  }
}
