import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_it/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfileScreen extends StatelessWidget {
  //UpdateProfileScreen({Key? key}) : super(key: key);
  final String userId;  

  UpdateProfileScreen({required this.userId});
  get width => null;
  Future<void> deleteUser(String uid) async {
    try {
      // Get the current user
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {  
  print('User ID: ${user.uid}');
} else {  
  print('User is not authenticated');
}

      // Delete the Firestore document associated with the user
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();

      // Delete the user account
      await user?.delete();
    } catch (e) {
      print('Error deleting user: $e');
      // Handle any errors here
    } 
  }
   
    @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: kBlack)),
        title: Text(tEditProfile, style: TextStyle(color: Colors.black, fontSize: 22),
        )),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
            Stack(
              children: [
                SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), child: Image(image: AssetImage(tProfileImage))),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,                
                child: Container(
                  width: 35, 
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), 
                    color: tPrimaryColor),
                child: const Icon(
                Icons.camera, size: 20, color: Colors.black)
                ),), 
              ],
            ),
            const SizedBox(height: 50),
            Form(child: 
            Column(         
              children: [
                TextFormField(
                  decoration:InputDecoration(label: Text('Name'), prefixIcon: Icon(Icons.account_box, size: 20, color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                    prefixIconColor: kBlue,
                    floatingLabelStyle:  TextStyle(color: kBlack),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                ),
                const SizedBox(height: 30),
                  TextFormField(
                  decoration:InputDecoration(label: Text('Email'), prefixIcon: Icon(Icons.mail, size: 20, color: Colors.black),                  
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                    prefixIconColor: kBlue,
                    floatingLabelStyle:  TextStyle(color: kBlack),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                ),                
                const SizedBox(height: 30),
                  TextFormField(
                  decoration:InputDecoration(label: Text('Phone Number'), prefixIcon: Icon(Icons.phone, size: 20, color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                    prefixIconColor: kBlue,
                    floatingLabelStyle:  TextStyle(color: kBlack),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                ),                
                const SizedBox(height: 30),
                  TextFormField(
                  decoration:InputDecoration(label: Text('Password'), prefixIcon: Icon(Icons.lock, size: 20, color: Colors.black),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
                    prefixIconColor: kBlue,
                    floatingLabelStyle:  TextStyle(color: kBlack),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: kBlack))),
                ),                  
                SizedBox(height: 30),   
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => UpdateProfileScreen(userId: '',)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(tEditProfile,
                            style: TextStyle(color: tDarkColor)),
                      ),
                    ), 
                const SizedBox(height: 30),
                Row(children: [                  
                  ElevatedButton(onPressed: ()  async {
                  // Assuming you have the user's UID
                  await deleteUser(userId);
                }, style: 
                  ElevatedButton.styleFrom(backgroundColor: Colors.redAccent.withOpacity(0.1),
                  elevation: 0,
                  foregroundColor: Colors.red,
                  shape: const StadiumBorder(),
                  side: BorderSide.none),
                  child: const Text('delete'),
                  ),
                ],)
              ],
            ))
            ]
            ), 
               
      ),
                      )
  );
  }
  }