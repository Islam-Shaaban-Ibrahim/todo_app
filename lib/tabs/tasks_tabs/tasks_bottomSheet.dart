import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';

import 'package:todo_app/providers/settings_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var selectedDate = DateTime.now();
  var dateFormat = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
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
          ),
          TextField(
              decoration: InputDecoration(
            hintText: "Enter Your Task ",
            hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 16,
                color: provider.isDark
                    ? AppTheme.whiteColor
                    : AppTheme.blackColor),
          )),
          TextField(
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
          SizedBox(
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
          SizedBox(
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
                    EdgeInsets.symmetric(vertical: 12)),
                backgroundColor:
                    MaterialStatePropertyAll(AppTheme.primaryColor)),
            onPressed: () {},
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
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: DateTime.now(),
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
