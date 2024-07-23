import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 270,
                  height: 310,
                  child: Image(
                    image: AssetImage('assets/images/taskit.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
              child: Divider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
