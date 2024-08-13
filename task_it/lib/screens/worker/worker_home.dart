import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:task_it/constants/colors.dart';

class WorkerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: _buildAppBar(context),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: kWhite,
            ),
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
                   ],
                ),
                Expanded(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!userSnapshot.hasData || userSnapshot.data == null) {
                        return Center(child: Text('No user data found'));
                      }

                      String? workerName = userSnapshot.data!['name'];

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('tasks')
                            .where('worker', isEqualTo: workerName)
                            .snapshots(),
                        builder: (context, taskSnapshot) {
                          if (!taskSnapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          var tasks = taskSnapshot.data!.docs;
                          tasks.sort((a, b) {
                            bool aCompleted = a['status'] == 'Completed';
                            bool bCompleted = b['status'] == 'Completed';
                            return aCompleted && !bCompleted ? 1 : -1;
                          });

                          return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              var task = tasks[index];
                              bool isCompleted = task['status'] == 'Completed';
                              return Card(
                                child: ListTile(
                                  leading: Checkbox(
                                    activeColor: kBlack,
                                    value: isCompleted,
                                    onChanged: (bool? value) {
                                  if (task['manualInput'] == true &&
                                      value == true) {
                                    _showManualInputDialog(context, task);
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(task.id)
                                        .update({
                                      'status':
                                          value! ? 'Completed' : 'Pending',
                                    });
                                  }
                                },
                                  ),
                                  isThreeLine: true,
                                  title: Text(
                                    task['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Time: ${task['dueTime']} \n ${task['category']}',
                                  ),
                                  tileColor: isCompleted
                                      ? kGrey.withOpacity(0.5)
                                      : kWhite,
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Material(
      elevation: 0,
      child: ClipRRect(
        child: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: kBlack,
          elevation: 0,
          iconTheme: IconThemeData(color: kWhite),
          title: Center(
            child: Text(
              textAlign: TextAlign.center,
              'Assignments',
              style: TextStyle(
                color: kWhite,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
        ),
      ),
    );
  }

  void _showManualInputDialog(BuildContext context, DocumentSnapshot task) {
    TextEditingController amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Enter Amount',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, // Restrict input to digits only
                ],
                decoration: InputDecoration(
                  hintText: 'Amount',
                  errorText: amountController.text.isNotEmpty &&
                          int.tryParse(amountController.text) == null
                      ? 'Please enter a valid integer'
                      : null,
                ),
                onChanged: (value) {
                  (context as Element).markNeedsBuild();
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  int? manualAmount = int.tryParse(amountController.text);
                  if (manualAmount == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please input a valid integer')),
                    );
                    return;
                  }

                  FirebaseFirestore.instance
                      .collection('tasks')
                      .doc(task.id)
                      .update({
                    'manualInputAmount': manualAmount,
                    'status': 'Completed',
                  });
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
