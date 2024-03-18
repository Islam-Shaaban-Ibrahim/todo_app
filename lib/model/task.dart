import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;
  Task(
      {this.id = '',
      required this.title,
      required this.dateTime,
      required this.description,
      this.isDone = false});
  Task.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          title: json['title'],
          description: json['description'],
          isDone: json['isDone'],
          dateTime: (json['dateTime'] as Timestamp).toDate(),
        );

  Map<String, dynamic> toJson(Task task) {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dateTime": (Timestamp.fromDate(dateTime)),
      "isDone": isDone
    };
  }
}
