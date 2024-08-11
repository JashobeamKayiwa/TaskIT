import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/profile/update_profile.dart';
import 'package:task_it/profile/widgets/profile_menu.dart';

class UserProfile extends StatelessWidget {
  final String userId;

  UserProfile({required this.userId});
  get width => null;
  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (snapshot.exists) {
      return snapshot.data() as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return FutureBuilder<Map<String, dynamic>?>(
      future:
          getUserDetails(userId), // Replace 'userId' with the actual user ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('User not found'));
        } else {
          var userData = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60.0),
              child: Material(
                elevation: 0,
                child: ClipRRect(
                  child: AppBar(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    title: Row(
                      children: [
                        Text(
                          'User Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.white),
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image(image: AssetImage(tProfileImage)),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: tPrimaryColor,
                            ),
                            // child: const Icon(Icons.edit,
                            //     size: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('${userData['name']}'),
                    Text('${userData['email']}'),
                    const SizedBox(height: 20),                    
                    const SizedBox(height: 30),
                    //const Divider(),                    
                    ProfileMenuWidget(
                        title: 'Name: ${userData['name']}',
                        icon: Icons.account_box,
                        onPress: () {}),
                    // ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: () {}),
                    ProfileMenuWidget(
                        title: 'Email: ${userData['email']}',
                        icon: Icons.mail,
                        onPress: () {}),
                    // const Divider(color: Colors.grey),
                    // const SizedBox(height: 10),
                    ProfileMenuWidget(
                        title: 'Phone Number: ${userData['phoneNumber']}',
                        icon: Icons.phone,
                        onPress: () {}),
                    ProfileMenuWidget(
                        title: "Logout",
                        icon: Icons.no_accounts,
                        textColor: Colors.red,
                        onPress: () {}),
                        const SizedBox(height: 10),
                        SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => UpdateProfileScreen(userId: 'user.uid',)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(tEditProfile,
                            style: TextStyle(color: tDarkColor)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}





// class UserProfile extends StatelessWidget {
//   final String userId;

//   UserProfile({required this.userId});

//   Future<Map<String, dynamic>?> getUserDetails(String userId) async {
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
//     if (snapshot.exists) {
//       return snapshot.data() as Map<String, dynamic>;
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: FutureBuilder<Map<String, dynamic>?>(
//         future: getUserDetails(userId),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data == null) {
//             return Center(child: Text('User not found'));
//           } else {
//             var userData = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Name: ${userData['name']}', style: TextStyle(fontSize: 20)),
//                   SizedBox(height: 8),
//                   Text('Phone Number: ${userData['phoneNumber']}', style: TextStyle(fontSize: 20)),
//                   SizedBox(height: 8),
//                   Text('Email: ${userData['email']}', style: TextStyle(fontSize: 20)),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
