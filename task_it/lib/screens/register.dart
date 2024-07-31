import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/functions/authfunctions.dart';

import '../widgets/forms.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  String selectedRole = 'Manager'; // Default role

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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildLabeledFormField(
                          "Full Name",
                          _nameController,
                          Icons.person_outline_sharp,
                          (value) {
                            if (value!.isEmpty) {
                              return "Please enter full name";
                            } else if (value.trim().split(' ').length < 2) {
                              return "Please enter at least two names";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        _buildLabeledFormField(
                          "Email",
                          _emailController,
                          Icons.email_outlined,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!value.contains('@')) {
                              return "messi@example.com";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        _buildLabeledFormField(
                          "Password",
                          _passwordController,
                          Icons.lock_outline,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            } else if (value.length <= 6) {
                              return "Password must be more than 6 characters";
                            }
                            return null;
                          },
                          obscureText: !_isPasswordVisible, // Show asterisks
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 16.0),
                        _buildLabeledFormField(
                          "Phone Number",
                          _phoneController,
                          Icons.phone_outlined,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter phone number";
                            } else if (value.length != 10 ||
                                !RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "Please enter a valid 10-digit phone number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        _buildTextFormField(),
                        SizedBox(height: 20.0),
                        RegButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {

                              AuthService.registerUser(
                                _emailController.text,
                                _passwordController.text,
                                _nameController.text,
                                _phoneController.text,
                                selectedRole,
                                context,
                              );

                              // Call the static registerUser function directly
                              // final user = UserModel(
                              //     email: _emailController.text.trim(),
                              //     fullName: _nameController.text.trim(),
                              //     password: _passwordController.text.trim(),
                              //     phoneNo: _phoneController.text.trim(),
                              //     role: _selectedRole);
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
        labelText: 'Role',
        fillColor: kGrey,
        border: OutlineInputBorder(),
      ),
      value: selectedRole,
      items: <String>['Manager', 'Worker'].map((String role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (String? newRole) {
        setState(() {
          selectedRole = newRole!;
        });
      },
    );
  }

  Widget _buildLabeledFormField(
    String label,
    TextEditingController controller,
    IconData icon,
    FormFieldValidator<String> validator, {
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        TextFormField(
          validator: validator,
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            fillColor: kGrey,
            suffixIcon: suffixIcon ?? Icon(icon),
            border: OutlineInputBorder(),
          ),
          obscureText: obscureText, // Show asterisks if true
        ),
      ],
    );
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
}

           