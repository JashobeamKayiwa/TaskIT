import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
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