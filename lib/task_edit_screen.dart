import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/task_edit_box.dart';

class TaskEdit extends StatelessWidget {
  static const String routeName = "taskEdit";

  const TaskEdit({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: provider.appTheme == ThemeMode.light
              ? AppTheme.backgroundColor
              : AppTheme.backgroundDarkColor,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.22,
          width: double.infinity,
          color: AppTheme.primaryColor,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: const TaskEditBox(),
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Text(
                AppLocalizations.of(context)!.todoList,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        )
      ],
    );
  }
}
