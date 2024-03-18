import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: EasyDateTimeLine(
        headerProps: EasyHeaderProps(
          showSelectedDate: false,
          monthStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: provider.appTheme == ThemeMode.light
                ? Colors.white
                : Colors.black,
          ),
          padding: const EdgeInsets.symmetric(vertical: 0),
          monthPickerType: MonthPickerType.switcher,
        ),
        initialDate: taskProvider.selectedDate,
        dayProps: EasyDayProps(
          activeDayStyle: DayStyle(
            monthStrStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            dayNumStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            dayStrStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
            decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light
                    ? Colors.white
                    : AppTheme.taskDarkColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          todayStyle: DayStyle(
            dayNumStyle: TextStyle(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
            monthStrStyle: TextStyle(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
            dayStrStyle: TextStyle(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
            decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light
                    ? Colors.white
                    : AppTheme.taskDarkColor,
                borderRadius: BorderRadius.circular(10)),
          ),
          inactiveDayStyle: DayStyle(
            dayNumStyle: TextStyle(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
            monthStrStyle: TextStyle(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
            dayStrStyle: TextStyle(
              color: provider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
            decoration: BoxDecoration(
                color: provider.appTheme == ThemeMode.light
                    ? Colors.white
                    : AppTheme.taskDarkColor,
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        onDateChange: (newDate) {
          taskProvider.changeSelectedDate(newDate);
        },
        locale: provider.appLanguage,
      ),
    );
  }
}
