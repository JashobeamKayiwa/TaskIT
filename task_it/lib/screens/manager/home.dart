import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_it/constants/colors.dart';
import 'package:task_it/screens/manager/tasker.dart';
import 'package:task_it/screens/manager/worker_tile.dart';
import 'package:task_it/widgets/tiles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: _buildAppBar(),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 20),
                child: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Tiles(
                    leadingIcon: Icon(Icons.account_circle_sharp,
                        size: 60, color: kBlack),
                    titleText: 'Personal',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkerTile()));
                    },
                  ),
                  SizedBox(height: 20),
                  Tiles(
                    leadingIcon: Icon(Icons.work, size: 60, color: kBlack),
                    titleText: 'Work',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tasker()));
                    },
                  ),
                  SizedBox(height: 20),
                  Tiles(
                    leadingIcon:
                        Icon(Icons.attach_money, size: 60, color: kBlack),
                    titleText: 'Finance',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkerTile()));
                    },
                  ),
                ],
              ))
            ],
          )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
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
            Text('Welcome Michelle',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
        actions: [Icon(Icons.add_alert_rounded, color: Colors.black, size: 40)],
      ),
    ),
  );
}

Widget _buildBottomNavigationBar() {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
            )
          ]),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: kBlack,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            items: [
              BottomNavigationBarItem(
                  label: 'Home', icon: Icon(Icons.home_rounded, size: 40)),
              BottomNavigationBarItem(
                  label: 'Finances',
                  icon: Icon(Icons.attach_money_outlined, size: 40)),
              BottomNavigationBarItem(
                  label: 'Person', icon: Icon(Icons.person_rounded, size: 40)),
            ],
          )));
}
