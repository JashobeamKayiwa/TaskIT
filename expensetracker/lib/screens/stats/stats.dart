import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/task_model.dart';

class WorkersProfileScreen extends StatefulWidget {
  const WorkersProfileScreen({super.key});

  @override
  _WorkersProfileScreenState createState() => _WorkersProfileScreenState();
}

class _WorkersProfileScreenState extends State<WorkersProfileScreen> {
  final List<String> transactionTypes = ['Income', 'Expense', 'Activity'];
  String selectedType = 'Activity';

  List<Task> tasks = [];
  int tasksDone = 0;
  int tasksLeft = 0;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final snapshot = await FirebaseFirestore.instance.collection('tasks').get();
    final List<Task> loadedTasks = [];
    int doneCount = 0;

    for (var doc in snapshot.docs) {
      Task task = Task.fromMap(doc.data(), doc.id);
      loadedTasks.add(task);
      if (task.isDone) doneCount++;
    }

    setState(() {
      tasks = loadedTasks;
      tasksDone = doneCount;
      tasksLeft = tasks.length - tasksDone;
    });
  }

  void updateTaskStatus(Task task, bool isDone) async {
    task.isDone = isDone;
    await FirebaseFirestore.instance.collection('tasks').doc(task.id).update(task.toMap());

    setState(() {
      tasksDone += isDone ? 1 : -1;
      tasksLeft = tasks.length - tasksDone;
    });
  }

  double calculateCompletionPercentage() {
    if (tasks.isEmpty) return 0;
    return (tasksDone / tasks.length) * 100;
  }

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
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.person,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        Text(
                          'Customer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Colors.grey,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Daily Task Completion',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          CustomPaint(
                            painter: ProgressArcPainter(calculateCompletionPercentage()),
                            size: const Size(100, 100),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${calculateCompletionPercentage().toStringAsFixed(1)}%',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Tasks Done',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '$tasksDone',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tasks Left',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '$tasksLeft',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: tasks[i].color,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    tasks[i].icon,
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tasks[i].name,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).colorScheme.onSurface,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('Yesterday'),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DropdownButton<String>(
                                  value: selectedType,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedType = newValue!;
                                    });
                                  },
                                  items: transactionTypes.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                                CircularCheckBox(
                                  value: tasks[i].isDone,
                                  onChanged: (bool? value) {
                                    updateTaskStatus(tasks[i], value!);
                                  },
                                  activeColor: Colors.green,
                                  checkColor: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color activeColor;
  final Color checkColor;

  const CircularCheckBox({
    required this.value,
    this.onChanged,
    this.activeColor = Colors.blue,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onChanged != null) {
          onChanged!(!value);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: activeColor,
          ),
          color: value ? activeColor : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: value
              ? Icon(
                  Icons.check,
                  size: 18.0,
                  color: checkColor,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  size: 18.0,
                  color: Colors.transparent,
                ),
        ),
      ),
    );
  }
}



class ProgressArcPainter extends CustomPainter {
  final double completionPercentage;

  ProgressArcPainter(this.completionPercentage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * (completionPercentage / 100);

    if (completionPercentage == 0.0) {
      // Draw a full circle with a distinct color when the percentage is 0
      paint.color = Colors.grey;
      canvas.drawCircle(center, radius, paint);
    } else {
      paint.shader = LinearGradient(
        colors: [
          Colors.white12,
          Colors.black,
        ],
        stops: [
          0.0,
          1.0,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

