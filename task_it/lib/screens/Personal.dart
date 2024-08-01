// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task_it/view_models/app_view.dart';
// import 'package:task_it/screens/add_view.dart';
// import 'package:task_it/screens/header.dart';
// import 'package:task_it/screens/task_info.dart';
// import 'package:task_it/screens/task_list.dart';

// void main() {
//   runApp(ChangeNotifierProvider(
//       create: (context) => personal(), child: const MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: TaskPage(),
//     );
//   }
// }


// class TaskPage extends StatelessWidget {
//   const TaskPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           bottom: false,
//           child: Column(
//             children: [
//               // Header View
//               Expanded(flex: 1, child: HeaderView()),

//               // Task Info View
//               Expanded(flex: 1, child: TaskInfoView()),

//               // Task List View
//               Expanded(flex: 7, child: TaskListView()),
//             ],
//           ),
//         ),
//         floatingActionButton: const AddTaskView());
//   }
// }
