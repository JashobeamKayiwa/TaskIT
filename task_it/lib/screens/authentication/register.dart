import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/functions/authfunctions.dart';

import '../../widgets/forms.dart';

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

  