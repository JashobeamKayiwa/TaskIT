// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:task_it/view_models/app_view.dart';
// import 'package:task_it/screens/bottom_sheets/del_bottom.dart';
// import 'package:task_it/screens/bottom_sheets/settings.dart';

// class HeaderView extends StatelessWidget {
//   const HeaderView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<personal>(
//       builder: (context, viewModel, child) {
//         return Row(
//           children: [
//             Expanded(
//                 flex: 3,
//                 child: Container(
//                   margin: EdgeInsets.only(left: 15),
//                   child: Column(children: [
//                     Expanded(
//                       flex: 1,
//                       child: Align(
//                         alignment: Alignment.bottomLeft,
//                         child: FittedBox(
//                           fit: BoxFit.fitHeight,
//                           child: Text("Welcome back,",
//                               style: TextStyle(
//                                   fontSize: 23,
//                                   fontWeight: FontWeight.w400,
//                                   color: viewModel.clrLvl4)),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       flex: 2,
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: FittedBox(
//                           fit: BoxFit.fitHeight,
//                           child: Text(viewModel.username,
//                               style: TextStyle(
//                                   fontSize: 42,
//                                   fontWeight: FontWeight.bold,
//                                   color: viewModel.clrLvl4)),
//                         ),
//                       ),
//                     )
//                   ]),
//                 )),
//             // Trash Icon
//             Expanded(
//                 flex: 1,
//                 child: InkWell(
//                     onTap: () {
//                       HapticFeedback.mediumImpact();
//                       viewModel.bottomSheetBuilder(
//                           DeleteBottomSheetView(), context);
//                     },
//                     child: Icon(Icons.delete,
//                         color: viewModel.clrLvl3, size: 40))),
//             // Settings Icon
//             Expanded(
//                 flex: 1,
//                 child: InkWell(
//                     onTap: () {
//                       HapticFeedback.mediumImpact();
//                       viewModel.bottomSheetBuilder(
//                           SettingsBottomSheetView(), context);
//                     },
//                     child: Icon(Icons.settings,
//                         color: viewModel.clrLvl3, size: 40))),
//           ],
//         );
//       },
//     );
//   }
// }
