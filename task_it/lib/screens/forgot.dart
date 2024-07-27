import 'package:flutter/material.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "CO\nDE",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 80.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
