import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: _buildAppBar(),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: kWhite,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildTextFormField(_fNameController, "First Name",
                          Icons.person_outline_sharp),
                      SizedBox(height: 16.0),
                      _buildTextFormField(_lNameController, "Last Name",
                          Icons.person_outline_sharp),
                      SizedBox(height: 16.0),
                      _buildTextFormField(
                          _emailController, "Email", Icons.email_outlined),
                      SizedBox(height: 16.0),
                      _buildTextFormField(
                          _passwordController, "Password", Icons.lock_outline),
                      SizedBox(height: 16.0),
                      _buildTextFormField(_numberController, "Phone Number",
                          Icons.phone_outlined),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          onPressed: () {},
                          child:
                              Text('Sign In', style: TextStyle(color: kWhite)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBlack,
                            padding: EdgeInsets.only(
                              right: 90.0,
                              left: 90.0,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String hintText, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: kGrey,
        suffixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }
}

Widget _buildAppBar() {
  return Material(
    elevation: 0,
    child: ClipRRect(
      child: AppBar(
        backgroundColor: kBlack,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'CREATE ACCOUNT',
              style: TextStyle(
                color: kWhite,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Icon(Icons.add, color: kWhite, size: 40),
        ],
      ),
    ),
  );
}
