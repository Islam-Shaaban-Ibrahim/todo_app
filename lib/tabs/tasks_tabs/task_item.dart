import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/task_edit_screen.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return widget.task.isDone == true ? showDoneTask() : showNotDoneTask();
  }

  Widget showNotDoneTask() {
    var provider = Provider.of<SettingsProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);
    final authProvider = Provider.of<AuthProviders>(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(TaskEdit.routeName, arguments: widget.task);
      },
      child: Container(
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
                  FireBaseUtils.deleteTaskFromFireBase(
                          widget.task, authProvider.currentUser!.id)
                      .timeout(Duration(microseconds: 20), onTimeout: () {
                    taskProvider.getAllTasks(authProvider.currentUser!.id);
                    Fluttertoast.showToast(
                      msg: "Task Deleted successfully",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }).catchError((onError) {
                    Fluttertoast.showToast(
                      msg: "Something Went Wrong!",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  });
                },
                backgroundColor: AppTheme.redColor,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light
                    ? Colors.white
                    : AppTheme.taskDarkColor,
                borderRadius: BorderRadius.circular(15)),
            height: MediaQuery.of(context).size.height * 0.14,
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
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.task.title.trim(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppTheme.primaryColor),
                        ),
                        Expanded(
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            widget.task.description.trim(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: provider.isDark
                                        ? AppTheme.whiteColor
                                        : AppTheme.blackColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    isDone = !isDone;

                    final colRef = FireBaseUtils.getTasksCollection(
                        authProvider.currentUser!.id);
                    colRef
                        .doc(widget.task.id)
                        .update({"isDone": isDone}).timeout(
                            Duration(microseconds: 20), onTimeout: () {
                      taskProvider.getAllTasks(authProvider.currentUser!.id);
                    }).catchError((onError) {
                      Fluttertoast.showToast(
                        msg: "Something Went Wrong!",
                        toastLength: Toast.LENGTH_SHORT,
                      );
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
      ),
    );
  }

  Widget showDoneTask() {
    var provider = Provider.of<SettingsProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);
    final authProvider = Provider.of<AuthProviders>(context);
    FireBaseUtils.readUserFromFireBase(authProvider.currentUser!.id);
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
                FireBaseUtils.deleteTaskFromFireBase(
                        widget.task, authProvider.currentUser!.id)
                    .timeout(Duration(microseconds: 20), onTimeout: () {
                  taskProvider.getAllTasks(authProvider.currentUser!.id);
                  Fluttertoast.showToast(
                    msg: "Task Deleted successfully",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }).catchError((onError) {
                  Fluttertoast.showToast(
                    msg: "Something Went Wrong!",
                    toastLength: Toast.LENGTH_SHORT,
                  );
                });
              },
              backgroundColor: AppTheme.redColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.white
                  : AppTheme.taskDarkColor,
              borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height * 0.14,
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
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.task.title.trim(),
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppTheme.greenColor),
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          widget.task.description.trim(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: AppTheme.greenColor),
                        ),
                      )
                    ],
                  ),
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
                child: InkWell(
                  onTap: () {
                    isDone = !isDone;

                    final colRef = FireBaseUtils.getTasksCollection(
                        authProvider.currentUser!.id);
                    colRef
                        .doc(widget.task.id)
                        .update({"isDone": isDone}).timeout(
                            Duration(microseconds: 20), onTimeout: () {
                      taskProvider.getAllTasks(authProvider.currentUser!.id);
                    }).catchError((onError) {
                      Fluttertoast.showToast(
                        msg: "Something Went Wrong!",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    });
                  },
                  child: Text(
                    "Done !",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppTheme.greenColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
