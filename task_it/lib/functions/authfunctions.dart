import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_it/screens/manager/home1.dart';
import 'package:task_it/screens/manager/home2.dart'; // For other users

class CustomUser {
  final String uid;
  final String email;
  final String? name;
  final String? role;
  
  CustomUser({required this.uid, required this.email, this.name, this.role});

  String getEmail() {
    return this.email;
  }
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomUser? userFromFirebaseUser(User? user) {
    if (user == null) return null;
    return CustomUser(
      uid: user.uid,
      email: user.email!,
      name: user.displayName,
    );
  }

  Stream<CustomUser?> get user {
    return _auth.authStateChanges().map(userFromFirebaseUser);
  }

  static Future<void> registerUser(
    String email,
    String password,
    String name,
    String phoneNumber,
    String selectedRole,
    BuildContext context,
  ) async {
    try {
      // Register the user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Check if the user is not null
      if (user != null) {
        // Save user details before sending verification email
        await saveUserDetails(user.uid, name, phoneNumber, email, selectedRole);

        // Send email verification
        await user.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Registration Successful. Please verify your email.')),
        );

        // Navigate to the appropriate home page based on role
        await _navigateToHomePage(context, user.uid);

        // Inform user to check email and verify
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Email Verification'),
            content: Text(
                'A verification email has been sent to your email address. Please verify your email before proceeding.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );

        // Start checking for email verification
        bool emailVerified = await _checkEmailVerified(user);
        if (emailVerified) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Email verified successfully.')));

          // Automatically log in the user and navigate to the homepage
          await _navigateToHomePage(context, user.uid);
        }
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password provided is too weak')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Email provided already exists')));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  static Future<void> _navigateToHomePage(BuildContext context, String uid) async {
    try {
      // Fetch user role from Firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      String? role = userDoc['role'];

      if (role == 'Manager') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home2()), // Manager's Home
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home2()), // Other users' Home
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to navigate to home page: $e')));
    }
  }

  static Future<bool> _checkEmailVerified(User user) async {
    await Future.delayed(
        Duration(seconds: 3)); // Initial delay to allow time for verification
    while (true) {
      await Future.delayed(Duration(seconds: 5)); // Delay between checks
      await user.reload(); // Refresh the user
      if (user.emailVerified) {
        return true;
      }
    }
  }

  static Future<void> saveUserDetails(String userId, String name,
      String phoneNumber, String email, String selectedRole) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': selectedRole,
    });
  }
}
