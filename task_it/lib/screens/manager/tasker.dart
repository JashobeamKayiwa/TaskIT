import "package:flutter/material.dart";
import "package:task_it/constants/colors.dart";

class Tasker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBlack,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: _buildAppBar(),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: kWhite),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                  Text(
                    'Add Task+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: kBlack,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Won the World Cup'),
                      subtitle: Text('Year: 2022'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                    ListTile(
                      title: Text('Won the Copa America'),
                      subtitle: Text('Year: 2021, 2024'),
                      trailing: Icon(Icons.check_circle_outlined),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget _buildAppBar() {
  return Material(
    elevation: 0,
    child: ClipRRect(
      child: AppBar(
        backgroundColor: kBlack,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'LIONEL MESSI',
              style: TextStyle(
                color: kWhite,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Icon(Icons.circle_outlined, color: kWhite, size: 40),
        ],
      ),
    ),
  );
}
