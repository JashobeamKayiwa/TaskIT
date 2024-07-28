import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:task_it/screens/addtask.dart';

class AuthService {
  static Future<void> registerUser(
    String email,
    String password,
    String name,
    String phoneNumber,
    BuildContext context,
  ) async {
    try {
      // Register the user with email and password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Send email verification
      if (user != null) {
        await user.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful. Please verify your email.')),
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
          await saveUserDetails(user.uid, name, phoneNumber, email);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User details saved successfully.')));

          // Automatically log in the user
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        }
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password Provided is too weak')));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Email Provided already Exists')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  static Future<bool> _checkEmailVerified(User user) async {
    await Future.delayed(Duration(seconds: 3));  // Initial delay to allow time for verification
    while (true) {
      await Future.delayed(Duration(seconds: 5));  // Delay between checks
      await user.reload();  // Refresh the user
      if (user.emailVerified) {
        return true;
      }
    }
  }

  static Future<void> saveUserDetails(String userId, String name, String phoneNumber, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    });
  }
}
