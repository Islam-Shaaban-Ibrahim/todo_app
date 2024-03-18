import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectedDate = DateTime.now();
  void getAllTasks() async {
    final allTasks = await FireBaseUtils.getAllTasksFromFireBase();

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
    getAllTasks();
  }
}
