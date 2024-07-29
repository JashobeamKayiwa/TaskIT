import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

import '../widgets/forms.dart';

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
  final _formKey = GlobalKey<FormState>();
  bool isAdmin = false;
  bool isStaff = false;

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
                  Form(
                    key: _formKey,
                    child: Column(
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
                        _buildTextFormField(_passwordController, "Password",
                            Icons.lock_outline),
                        SizedBox(height: 16.0),
                        _buildTextFormField(_numberController, "Phone Number",
                            Icons.phone_outlined),
                        SizedBox(height: 8),            
                        Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Admin',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: isAdmin,
                                  onChanged: _handleAdminChanged,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  'Staff',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                leading: Checkbox(
                                  value: isStaff,
                                  onChanged: _handleStaffChanged,
                                ),
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 20.0),
                        RegButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')));
                            }
                          },
                        ),
                      ],
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
void _handleAdminChanged(bool? value) {
    setState(() {
      isAdmin = value ?? false;
      isStaff = !isAdmin;
    });
  }

  void _handleStaffChanged(bool? value) {
    setState(() {
      isStaff = value ?? false;
      isAdmin = !isStaff;
    });
  }
  Widget _buildTextFormField(
      TextEditingController controller, String hintText, IconData icon) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Fill out this field";
        } else {
          null;
        }
      },
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
      ),
    ),
  );
}
