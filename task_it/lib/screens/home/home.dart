import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust the height as needed
        child: _buildAppBar(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,),
          child: Column(
            children: [
              Expanded(
              child:ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom:20,),
                    child: Text('Dashboard',
                    style: TextStyle(
                      fontSize:30,
                      fontWeight: FontWeight.bold))
                  )
                ]
              )
            )
            ],
            )
      )
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
