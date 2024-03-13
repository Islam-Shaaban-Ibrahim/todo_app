import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/tabs/tasks_tabs/calender_widget.dart';
import 'package:todo_app/tabs/tasks_tabs/task_item.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        CalenderWidget(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                height: 25,
              ),
              itemBuilder: (context, index) => TaskItem(),
              itemCount: 20,
            ),
          ),
        )
      ],
    );
  }
}
