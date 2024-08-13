import 'package:flutter/material.dart';

class Task {
  String id;
  String name;
  bool isDone;
  Color color;
  Icon icon;

  Task({
    required this.id,
    required this.name,
    required this.isDone,
    required this.color,
    required this.icon,
  });

  factory Task.fromMap(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      name: data['name'],
      isDone: data['isDone'],
      color: Color(data['color']),
      icon: Icon(IconData(data['icon'], fontFamily: 'MaterialIcons')),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isDone': isDone,
      'color': color.value,
      'icon': icon.icon!.codePoint,
    };
  }
}
