import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {},
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
                margin: EdgeInsetsDirectional.only(start: 20, end: 15),
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
                      "Title",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppTheme.primaryColor),
                    ),
                    Text(
                      "Desc.",
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 15),
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppTheme.primaryColor,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
