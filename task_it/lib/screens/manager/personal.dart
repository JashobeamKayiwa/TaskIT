import "package:flutter/material.dart";
import "package:task_it/constants/colors.dart";

class Personal extends StatelessWidget {
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
                    Card(
                      child: ListTile(
                        isThreeLine: true,
                        title: Text('Win the World Cup',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Time: 20:22pm \n Lionel Messi'),
                        trailing: Icon(Icons.delete_outlined, color: kRedDark),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      );
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
              'WORK',
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


