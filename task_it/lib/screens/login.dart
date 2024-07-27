import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/screens/forgot.dart';
import 'package:task_it/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userNumber;
  final _numberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _numberController.addListener(_updateNumber);
  }

  void _updateNumber() {
    setState(() {
      _userNumber = _numberController.text;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                  child: Divider(
                    color: kGrey,
                    thickness: 2,
                  ),
                ),
                Text('LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 50.0),
                  child: TextFormField(
                      controller: _numberController,
                      decoration: InputDecoration(
                          hintText: "Phone No.",
                          fillColor: kGrey,
                          suffixIcon: Icon(Icons.person_outline_sharp),
                          border: OutlineInputBorder())),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 50.0),
                  child: TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          fillColor: kGrey,
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder())),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPage()));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blue[900], fontSize: 10.0),
                    )),
                ElevatedButton(
                    onPressed: () {},
                    child: Text('Sign In', style: TextStyle(color: kWhite)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlack,
                      padding: EdgeInsets.only(
                        right: 90.0,
                        left: 90.0,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: Text(
                      "Don't have an account, Create Account",
                      style: TextStyle(color: Colors.blue[900], fontSize: 10.0),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
