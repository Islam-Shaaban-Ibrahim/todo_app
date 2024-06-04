import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class TaskEditBox extends StatefulWidget {
  const TaskEditBox({super.key});

  @override
  State<TaskEditBox> createState() => _TaskEditBoxState();
}

class _TaskEditBoxState extends State<TaskEditBox> {
  final formKey = GlobalKey<FormState>();

  var dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Task;

    var provider = Provider.of<SettingsProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);
    final authProvider = Provider.of<AuthProviders>(context);
    return Center(
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
              color: provider.isDark
                  ? AppTheme.taskDarkColor
                  : AppTheme.whiteColor,
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.77,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Edit Task",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    color: provider.isDark
                        ? AppTheme.whiteColor
                        : AppTheme.blackColor),
                textAlign: TextAlign.center,
              ),
              TextFormField(
                  initialValue: args.title,
                  onChanged: (value) {
                    args.title = value;
                  },
                  style: TextStyle(
                      color: provider.isDark
                          ? AppTheme.whiteColor
                          : AppTheme.blackColor),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'INVALID INPUT';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your Task ",
                    hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        color: provider.isDark
                            ? AppTheme.whiteColor
                            : AppTheme.blackColor),
                  )),
              TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(150),
                ],
                initialValue: args.description,
                onChanged: (value) {
                  args.description = value;
                },
                style: TextStyle(
                    color: provider.isDark
                        ? AppTheme.whiteColor
                        : AppTheme.blackColor),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'INVALID INPUT';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Description",
                  hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                      color: provider.isDark
                          ? AppTheme.whiteColor
                          : AppTheme.blackColor),
                ),
                maxLines: 3,
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
                  dateFormat.format(args.dateTime),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 18,
                      color: provider.isDark
                          ? AppTheme.whiteColor
                          : AppTheme.blackColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 12)),
                    backgroundColor:
                        MaterialStatePropertyAll(AppTheme.primaryColor)),
                onPressed: () {
                  if (formKey.currentState?.validate() == false) {
                    return;
                  }

                  final colRef = FireBaseUtils.getTasksCollection(
                      authProvider.currentUser!.id);
                  colRef.doc(args.id).update({
                    "title": args.title,
                    "description": args.description,
                    "dateTime": args.dateTime
                  }).timeout(const Duration(microseconds: 10), onTimeout: () {
                    Navigator.pop(context);
                    taskProvider.getAllTasks(authProvider.currentUser!.id);
                    Fluttertoast.showToast(
                      msg: "Task Edited successfully",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }).catchError((onError) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                      msg: "Something Went Wrong!",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  });
                },
                child: Text(
                  "Save Changes",
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
      ),
    );
  }

  void showCalender() async {
    var args = ModalRoute.of(context)?.settings.arguments as Task;
    var chosenDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: args.dateTime,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    args.dateTime = chosenDate ?? args.dateTime;

    setState(() {});
  }
}
