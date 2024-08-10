import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatelessWidget {
  final String userId;

  UserProfile({required this.userId});

  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Material(
          elevation: 0,
          child: ClipRRect(
            child: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    'User Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: FutureBuilder<Map<String, dynamic>?>(
            future: getUserDetails(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('User not found'));
              } else {
                var userData = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${userData['name']}',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 8),
                    Text('Phone Number: ${userData['phoneNumber']}',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 8),
                    Text('Email: ${userData['email']}',
                        style: TextStyle(fontSize: 20)),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
