import 'package:flutter/material.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';

class CalenderWidget extends StatefulWidget {
  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13),
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
          padding: EdgeInsets.symmetric(vertical: 0),
          monthPickerType: MonthPickerType.switcher,
        ),
        initialDate: selectedDate,
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
          selectedDate = newDate;
          setState(() {});
        },
        locale: provider.appLanguage,
      ),
    );
  }
}
