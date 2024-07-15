import 'package:flutter/material.dart';
import 'package:task_it/constants/colors.dart';

class WorkerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: _buildAppBar(),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: const Column(
            children: [
              Row(
                children: [Text('Daily Task Completion', style: TextStyle(
                       fontSize: 12.0,
                       fontWeight: FontWeight.bold,
                       color: kBlack,
                     ),)],
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(children: [
                 Icon(Icons.circle_outlined, size: 90),  
                ],),
                Column(children: [
                  Text(
                    'Tasks Remaining: 0',
                    style: TextStyle(
                       fontSize: 12.0,
                       fontWeight: FontWeight.bold,
                       color: kBlack,
                     ),
                   ),
                   Text(
                     'Tasks Completed: 12',
                     style: TextStyle(
                       fontSize: 12.0,
                       fontWeight: FontWeight.bold,
                       color: kBlack,
                     ),
                   ),
                ],)
              ],),
              Row(children: [
                Text('+256 777101010')
              ],),
              Row(children: [
                Text(
                    'Tasks Remaining: 0',
                    style: TextStyle(
                       fontSize: 12.0,
                       fontWeight: FontWeight.bold,
                       color: kBlack,
                     ),
                   ),
                Text(
                    'Tasks Remaining: 0',
                    style: TextStyle(
                       fontSize: 12.0,
                       fontWeight: FontWeight.bold,
                       color: kBlack,
                     ),
                   ),
              ],)
            ],
          )),
    );
  }

  Widget _buildAppBar() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'LIONEL MESSI',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            Icon(Icons.more_vert, color: Colors.black, size: 40),
          ],
        ),
      ),
    );
  }
}


//child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Icon(Icons.circle_outlined, size: 90),
        //       ],
        //     ),
        //     SizedBox(width: 20), 
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             'Daily Task Completion',
        //             style: TextStyle(
        //               fontSize: 20.0,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           SizedBox(height: 10), 
        //           Text(
        //             'Tasks Remaining: 0',
        //             style: TextStyle(
        //               fontSize: 12.0,
        //               fontWeight: FontWeight.w100,
        //               color: kBlack,
        //             ),
        //           ),
        //           Text(
        //             'Tasks Completed: 12',
        //             style: TextStyle(
        //               fontSize: 12.0,
        //               fontWeight: FontWeight.w100,
        //               color: kBlack,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       Row(children: [
        //         Text('+256 777101010',
        //       style: TextStyle(
        //         fontSize: 10.0
        //       ),)
        //       ],) 
        //     )
        //   ],
        // ),
