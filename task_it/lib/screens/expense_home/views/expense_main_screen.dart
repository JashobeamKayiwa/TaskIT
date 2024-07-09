import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


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
                //  IconButton(onPressed: () {},
                //     icon: const Align(
                //       alignment: Alignment.centerRight,
                //       child: Icon(CupertinoIcons.settings)),
                //     ),
              ],
            ),
          ]
        )
      )
    );
  }
}