import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_it/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:task_it/functions/authfunctions.dart';
import 'package:task_it/profile/utils.dart';
import 'package:task_it/functions/resources/save_data.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? userId}) : super(key: userId);

  @override
  State<UpdateProfile> createState() => UpdateProfilePageState();
}

class UpdateProfilePageState extends State<UpdateProfile> {  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();  
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List? _image;
  bool _isPasswordVisible = false;
  String selectedRole = '';
  late final String userId;  

  get width => null;
  Future<void> deleteUser(String uid) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {  
  print('User ID: ${user.uid}');
} else {  
  print('User is not authenticated');
}

      await FirebaseFirestore.instance.collection('users').doc(userId).delete();

      await user?.delete();
    } catch (e) {
      print('Error deleting user: $e');      
    } 
  }


  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void saveProfile() async {

    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String phoneNumber = _phoneController.text;

    String resp = await StoreData().saveData(
      name : name,
      email : email,
      phoneNumber : phoneNumber,
      password : password,
      file : _image!, String: null);

  }
             
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(
          onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: kBlack)),
        title: Text(tEditProfile, style: TextStyle(color: Colors.black, fontSize: 22),
        )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [             
              _image != null ? 
                CircleAvatar(
                  radius: 60,
                  backgroundImage: MemoryImage(_image!),
                )
                :
              CircleAvatar(
                radius: 60,
                backgroundImage: 
                NetworkImage('tPrimaryColor'), child: Positioned(child: IconButton(onPressed: 
                selectImage, 
                    icon: Icon(
                      Icons.add_a_photo
                      ),
                ),
                bottom: -10,
                left: 80,
                ),   
                ),                   
          SizedBox(height: 50),
            Form(
              key: _formKey,
              child: 
            Column(         
              children: [
                TextFormField(
                      controller: _nameController,
                      decoration:InputDecoration(label: Text('Name'), prefixIcon: Icon(Icons.account_box, size: 20, color: Colors.black),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                      prefixIconColor: kBlue,
                      floatingLabelStyle:  TextStyle(color: kBlack),
                      focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                      validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter full name";
                            } else if (value.trim().split(' ').length < 2) {
                              return "Please enter at least two names";
                            }
                            return null;
                          },
                ),
                const SizedBox(height: 30),
                  TextFormField(
                      controller: _emailController,
                      decoration:InputDecoration(label: Text('Email'), prefixIcon: Icon(Icons.mail, size: 20, color: Colors.black),                  
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                      prefixIconColor: kBlue,
                      floatingLabelStyle:  TextStyle(color: kBlack),
                      focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                      validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                ),                
                const SizedBox(height: 30),
                  TextFormField(
                      controller: _phoneController,
                      decoration:InputDecoration(label: Text('Phone Number'), prefixIcon: Icon(Icons.phone, size: 20, color: Colors.black),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),                  
                      prefixIconColor: kBlue,
                      floatingLabelStyle:  TextStyle(color: kBlack),
                      focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                      validator: (value) {
                            if (value == null || value.length != 10 ||
                                !RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return "Please enter a valid 10-digit phone number";
                            }
                            return null;
                          },
                ),                
                const SizedBox(height: 30),
                  TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration:InputDecoration(label: Text('Password'), prefixIcon: Icon(Icons.lock, size: 20, color: Colors.black),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),                  
                      prefixIconColor: kBlue,
                      floatingLabelStyle:  TextStyle(color: kBlack),
                      focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                      validator: (value) {
                            if (value == null || value.length <= 6) {
                              return "Password must be more than 6 characters";
                            }
                            return null;
                          },
                ),                  
                SizedBox(height: 30),   
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: saveProfile,
                        // () {
                        //   if (_formKey.currentState!.validate()) {
                        //       AuthService.registerUser(
                        //       _emailController.text,
                        //       _passwordController.text,
                        //       _nameController.text, 
                        //       _phoneController.text,
                        //        selectedRole,
                        //         context,                       
                        //       );
                        // };
                        //     Navigator.pop
                        //     (context);                            
                        // },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(tsaveProfile,
                            style: TextStyle(color: tDarkColor)),
                      ),
                    ), 
                // const SizedBox(height: 30),
                // Row(children: [                  
                //   ElevatedButton(onPressed: ()  async {
                //   // Assuming you have the user's UID
                //   await deleteUser(userId);
                // }, style: 
                //   ElevatedButton.styleFrom(backgroundColor: Colors.redAccent.withOpacity(0.1),
                //   elevation: 0,
                //   foregroundColor: Colors.red,
                //   shape: const StadiumBorder(),
                //   side: BorderSide.none),
                //   child: const Text('delete'),
                //   ),
                // ],)
              ],
            ))
          ], )
          ),
      ),
      );
  }
  }
  
  