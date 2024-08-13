import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import'package:flutter/material.dart';

List<Map<String,dynamic>> transactionData= [
  {
    'icon':const FaIcon(FontAwesomeIcons.burger, color: Colors.white,),
    'color': Colors.orangeAccent,
    'name':'Food',
    'totalAmount':'- UGX 50,000',
    'date':'Today',
  },

   {
    'icon':const FaIcon(FontAwesomeIcons.bagShopping ,color: Colors.white,),
    'name':'Shopping',
    'color':Colors.purpleAccent,
    'totalAmount':'- UGX 500,000',
    'date':'Today',
  },

  {
    'icon':const FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white,),
    'name':'Health',
    'color':Colors.lightGreenAccent,
    'totalAmount':'- UGX 100,000',
    'date':'Yesterday',
  },

  {
    'icon':const FaIcon(FontAwesomeIcons.planeArrival,color: Colors.white,),
    'name':'Travel',
    'color':Colors.blueAccent,
    'totalAmount':'- UGX 200,000',
    'date':'Yesterday',
  }
];