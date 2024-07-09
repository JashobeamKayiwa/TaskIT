import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children:[
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                          shape:BoxShape.circle,
                          color: Colors.orangeAccent,
                          )
                        ),
                         const Icon(CupertinoIcons.person_fill,
                           color: Colors.black
                         ),
                      ],
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.outline
                          
                          ),
                        ),
                        Text('Madrine',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface
                          
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
                          const SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
              gradient:LinearGradient(
            colors:[
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
             Theme.of(context).colorScheme.tertiary,
           ],
           transform: const GradientRotation(pi / 4),
           ),
              borderRadius: BorderRadius.circular(25),
              boxShadow:const [
                BoxShadow(
                blurRadius:4,
                color:Colors.grey,
                offset: Offset(5, 5) 
                ),
              ]
            ),
          )
              ],
              
            ),
          ]
        )
      )
    );
  }
}