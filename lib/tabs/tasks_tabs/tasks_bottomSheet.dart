import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/my_theme.dart';

import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var selectedDate = DateTime.now();
  var dateFormat = DateFormat("dd/MM/yyyy");
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add a New Task",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  color: provider.isDark
                      ? AppTheme.whiteColor
                      : AppTheme.blackColor),
              textAlign: TextAlign.center,
            ),
            TextFormField(
                style: TextStyle(
                    color: provider.isDark
                        ? AppTheme.whiteColor
                        : AppTheme.blackColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'INVALID INPUT';
                  }
                  return null;
                },
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter Your Task ",
                  hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      color: provider.isDark
                          ? AppTheme.whiteColor
                          : AppTheme.blackColor),
                )),
            TextFormField(
              style: TextStyle(
                  color: provider.isDark
                      ? AppTheme.whiteColor
                      : AppTheme.blackColor),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'INVALID INPUT';
                }
                return null;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "Enter Your Description",
                hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16,
                    color: provider.isDark
                        ? AppTheme.whiteColor
                        : AppTheme.blackColor),
              ),
              maxLines: 4,
            ),
            const SizedBox(
              height: 15,
            ),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                "Select Date",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: provider.isDark
                        ? AppTheme.whiteColor
                        : AppTheme.blackColor),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showCalender();
              },
              child: Text(
                dateFormat.format(selectedDate),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    color: provider.isDark
                        ? AppTheme.whiteColor
                        : AppTheme.blackColor),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12)),
                  backgroundColor:
                      MaterialStatePropertyAll(AppTheme.primaryColor)),
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                Task task = Task(
                  dateTime: selectedDate,
                  description: descriptionController.text,
                  title: titleController.text,
                );
                FireBaseUtils.addTaskToFireStore(task).timeout(
                  const Duration(milliseconds: 100),
                  onTimeout: () {
                    taskProvider.getAllTasksFromFireStore();
                  },
                ).catchError((e) {});

                Navigator.of(context).pop();
              },
              child: Text(
                "Add",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    color: provider.isDark
                        ? AppTheme.whiteColor
                        : AppTheme.blackColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: selectedDate,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
