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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Daily Task Completion',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.circle_outlined, size: 90),
                    ],
                  ),
                  Column(
                    children: [
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
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 4),
                  Text('+256 777101010'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                  Text(
                    'Add Task+',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text('Won the Copa America',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Year: 2021, 2024'),
                        trailing: Icon(Icons.check_circle_outlined),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Won the Copa America',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Year: 2021, 2024'),
                        trailing: Icon(Icons.check_circle_outlined),
                      ),
                    ),
                  ],
                ),
              )
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
