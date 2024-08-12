import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:task_it/constants/colors.dart';

class TaskCompletionIndicator extends StatelessWidget {
  final int allTasks;
  final int completedTasks;

  TaskCompletionIndicator(
      {required this.allTasks, required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    double percent = allTasks > 0 ? completedTasks / allTasks : 0;
    String percentText = (percent * 100).toStringAsFixed(1) + "%";

    return Container(
      child: CircularPercentIndicator(
        radius: 25.0,
        lineWidth: 5.0,
        percent: percent,
        center: Text(percentText),
        progressColor: kBlack,
      ),
    );
  }
}
