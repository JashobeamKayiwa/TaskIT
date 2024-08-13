import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_it/constants/colors.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

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
            Form(child: Column(
              children: [
                TextFormField(
                  decoration:InputDecoration(label: Text('Name'), prefixIcon: Icon(Icons.account_box, size: 20, color: Colors.black)),
                ),
                  TextFormField(
                  decoration:InputDecoration(label: Text('Email'), prefixIcon: Icon(Icons.mail, size: 20, color: Colors.black)),
                ),
                const SizedBox(height: 30),
                  TextFormField(
                  decoration:InputDecoration(label: Text('Phone Number'), prefixIcon: Icon(Icons.phone, size: 20, color: Colors.black)),
                ),
                const SizedBox(height: 30),
                  TextFormField(
                  decoration:InputDecoration(label: Text('Password'), prefixIcon: Icon(Icons.fingerprint, size: 20, color: Colors.black)),
                  ),     
            ],
            ))
            ]
            ), 
                     
      ),
    )
    );
  }
}