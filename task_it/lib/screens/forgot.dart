import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:task_it/constants/colors.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  Text(
                    "Please enter verification code",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  OtpTextField(
                    numberOfFields: 7,
                    fillColor: const Color.fromARGB(255, 211, 209, 209),
                    filled: true,
                    onSubmit: (code) {
                      print("Code is $code");
                    },
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Next", style: TextStyle(color: kWhite)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kBlack,
                          padding: EdgeInsets.only(left: 100.0, right: 100.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
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
