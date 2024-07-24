import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/screens/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _userEmail;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateMail);
  }

  void _updateMail() {
    setState(() {
      _userEmail = _emailController.text;
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: "Email",
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
                        suffixIcon: Icon(Icons.lock_outline_rounded),
                        border: OutlineInputBorder())),
              ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()))
                  },
                  child: Text(
                    "Don't have an account, Create Account",
                    style: TextStyle(color: Colors.blue[900], fontSize: 10.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
