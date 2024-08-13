import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_it/constants/colors.dart';

class TaskCompletionIndicator extends StatelessWidget {
  final int allTasks;
  final int completedTasks;

  TaskCompletionIndicator({
    required this.allTasks,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    double percent = allTasks > 0 ? completedTasks / allTasks : 0;
    String percentText = (percent * 100).toStringAsFixed(0) + "%";

    double screenWidth = MediaQuery.of(context).size.width;
    double radius = screenWidth * 0.1;
    double lineWidth = screenWidth * 0.025;

    return Container(
      child: CircularPercentIndicator(
        radius: radius,
        lineWidth: lineWidth,
        percent: percent,
        center: Text(
          percentText,
          style: TextStyle(fontSize: screenWidth * 0.07, fontWeight: FontWeight.bold),
        ),
        progressColor: kBlack,
        backgroundColor: kGrey.withOpacity(0.3),
      ),
    );
  }
}

class TaskCompletionIndicator2 extends StatelessWidget {
  final int allTasks;
  final int completedTasks;
  final double radius;
  final double lineWidth;

  TaskCompletionIndicator2({
    required this.allTasks,
    required this.completedTasks,
    this.radius = 20.0,
    this.lineWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    double progress = allTasks > 0 ? completedTasks / allTasks : 0.0;

    return Container(
      width: radius * 2,
      height: radius * 2,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: lineWidth,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 131, 115, 115)),
      ),
    );
  }
}
