// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:task_it/view_models/app_view.dart';
// import 'package:task_it/screens/bottom_sheets/add_task.dart';

// class AddTaskView extends StatelessWidget {
//   const AddTaskView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<personal>(builder: (context, viewModel, child) {
//       return SizedBox(
//         height: 60,
//         child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//                 backgroundColor: viewModel.clrLvl3,
//                 foregroundColor: viewModel.clrLvl1,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20))),
//             onPressed: () {
//               HapticFeedback.heavyImpact();
//               viewModel.bottomSheetBuilder(
//                   const AddTaskBottomSheetView(), context);
//             },
//             child: const Icon(
//               Icons.add,
//               size: 30,
//             )),
//       );
//     });
//   }
// }
