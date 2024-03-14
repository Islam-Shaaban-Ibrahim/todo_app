import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return widget.task.isDone == true ? showDoneTask() : showNotDoneTask();
  }

  Widget showNotDoneTask() {
    var provider = Provider.of<SettingsProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                FireBaseUtils.deleteTaskFromFireBase(widget.task)
                    .timeout(const Duration(microseconds: 500), onTimeout: () {
                  print("task deleted");
                });
                taskProvider.getAllTasksFromFireStore();
              },
              backgroundColor: AppTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.white
                  : AppTheme.taskDarkColor,
              borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height * 0.126,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(start: 20, end: 15),
                width: 4,
                color: AppTheme.primaryColor,
                height: MediaQuery.of(context).size.height * 0.073,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppTheme.primaryColor),
                    ),
                    Text(
                      widget.task.description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: provider.isDark
                              ? AppTheme.whiteColor
                              : AppTheme.blackColor),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  final colRef = FireBaseUtils.getTasksCollection();
                  colRef.doc(widget.task.id).update({"isDone": true}).timeout(
                      Duration(milliseconds: 100), onTimeout: () {
                    taskProvider.getAllTasksFromFireStore();
                  });
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 15),
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppTheme.primaryColor,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showDoneTask() {
    var provider = Provider.of<SettingsProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                FireBaseUtils.deleteTaskFromFireBase(widget.task)
                    .timeout(const Duration(microseconds: 100), onTimeout: () {
                  print("task deleted");
                });
                taskProvider.getAllTasksFromFireStore();
              },
              backgroundColor: AppTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.white
                  : AppTheme.taskDarkColor,
              borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height * 0.126,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.only(start: 20, end: 15),
                width: 4,
                color: AppTheme.greenColor,
                height: MediaQuery.of(context).size.height * 0.073,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.task.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppTheme.greenColor),
                    ),
                    Text(widget.task.description,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppTheme.greenColor))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsetsDirectional.only(end: 15),
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                child: Text(
                  "Done!",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppTheme.greenColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
