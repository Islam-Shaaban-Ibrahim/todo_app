import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/tabs/tasks_tabs/calender_widget.dart';
import 'package:todo_app/tabs/tasks_tabs/task_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<TaskProvider>(context);

    return Column(
      children: [
        const CalenderWidget(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 25,
              ),
              itemBuilder: (context, index) => TaskItem(
                task: taskProvider.tasks[index],
              ),
              itemCount: taskProvider.tasks.length,
            ),
          ),
        )
      ],
    );
  }
}
