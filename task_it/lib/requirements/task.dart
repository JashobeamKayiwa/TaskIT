class Task {
  String title;
  String deadline;
  String assigned_to;
  bool isCompleted;

  Task({required this.title, required this.deadline, required this.assigned_to,this.isCompleted = false});
}
