import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();
  Future<void> getAllTasksFromFireStore() async {
    final collectionReference = FireBaseUtils.getTasksCollection();
    final docsRef = await collectionReference.get();

    List<QueryDocumentSnapshot<Task>> tasksDocs = docsRef.docs;
    var allTasks = tasksDocs.map((e) => e.data()).toList();
    tasks = allTasks
        .where((task) =>
            task.dateTime.day == selectedDate.day &&
            task.dateTime.month == selectedDate.month &&
            task.dateTime.year == selectedDate.year)
        .toList();
    tasks.sort(
      (task, nextTask) {
        return task.dateTime.compareTo(nextTask.dateTime);
      },
    );
    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelectedDate) {
    selectedDate = newSelectedDate;
    getAllTasksFromFireStore();
  }
}
