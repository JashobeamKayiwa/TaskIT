import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:task_it/screens/manager/home.dart';
import 'package:task_it/screens/manager/home1.dart'; // Replace with your actual homepage import

class AuthService {
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
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
          SnackBar(content: Text('Registration Successful. Please verify your email.')),
        );

        // Navigate to the homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()), // Replace with your homepage widget
        );

        // Inform user to check email and verify
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Email Verification'),
            content: Text('A verification email has been sent to your email address. Please verify your email before proceeding.'),
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
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email verified successfully.')));
          
          // Automatically log in the user and navigate to the homepage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Home()), // Replace with your homepage widget
          );
        }
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password provided is too weak')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email provided already exists')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  static Future<bool> _checkEmailVerified(User user) async {
    await Future.delayed(Duration(seconds: 3)); // Initial delay to allow time for verification
    while (true) {
      await Future.delayed(Duration(seconds: 5)); // Delay between checks
      await user.reload(); // Refresh the user
      if (user.emailVerified) {
        return true;
      }
    }
  }

  static Future<void> saveUserDetails(String userId, String name, String phoneNumber, String email, String selectedRole) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': selectedRole,
    });
  }
}
