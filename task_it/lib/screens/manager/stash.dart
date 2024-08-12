// @override
//   void initState() {
//     super.initState();
//     fetchUserName();
//   }

//   Future<void> fetchUserName() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final userSnapshot = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();

//       setState(() {
//         userName = userSnapshot['name'];
//       });
//     }
//   }