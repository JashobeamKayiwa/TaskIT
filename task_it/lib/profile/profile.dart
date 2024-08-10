import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/profile/update_profile.dart';

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
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
                        IconButton(
                          onPressed: () {},
                          icon:
                              Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
                            child: const Icon(Icons.edit,
                                size: 20, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text('${userData['name']}'),
                    Text('${userData['email']}'),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const UpdateProfileScreen()),
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
                    const Divider(),
                    const SizedBox(height: 10),
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

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? userId,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: userId);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      //style: Theme.of(context).textTheme.bodyText?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child:
                  Icon(Icons.arrow_forward_ios, size: 18.0, color: Colors.grey))
          : null,
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
