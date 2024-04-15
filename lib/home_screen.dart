import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/tabs/settings_tab.dart';
import 'package:todo_app/tabs/tasks_tabs/tasks_bottomSheet.dart';
import 'package:todo_app/tabs/tasks_tabs/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  bool firstRun = true;
  List<Widget> tabs = [const TasksTab(), const SettingsTab()];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final authProvider = Provider.of<AuthProviders>(context);

    if (firstRun) {
      taskProvider.getAllTasks(authProvider.currentUser!.id);
      // provider.getAllPrefs();
      firstRun = false;
    }

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
          height: MediaQuery.of(context).size.height * 0.21,
          width: double.infinity,
          color: AppTheme.primaryColor,
        ),
        Scaffold(
          body: tabs[selectedIndex],
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  provider.changeLoginStatus();

                  taskProvider.tasks = [];

                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                },
                icon: Icon(Icons.logout),
              )
            ],
            title: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Text(
                selectedIndex == 0
                    ? AppLocalizations.of(context)!.todoList +
                        "    - ${authProvider.currentUser!.name} -"
                    : AppLocalizations.of(context)!.settings,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 8,
            padding: const EdgeInsets.all(0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                currentIndex: selectedIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.list_outlined,
                        size: 38,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings,
                        size: 30,
                      ),
                      label: '')
                ]),
          ),
          floatingActionButton: FloatingActionButton(
            splashColor: Colors.transparent,
            shape: CircleBorder(
                side: BorderSide(
                    width: 4,
                    color: provider.appTheme == ThemeMode.light
                        ? AppTheme.whiteColor
                        : AppTheme.taskDarkColor)),
            onPressed: () {
              showTaskBottomSheet();
            },
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ],
    );
  }

  void showTaskBottomSheet() async {
    final provider = Provider.of<SettingsProvider>(context, listen: false);
    await showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        backgroundColor:
            provider.isDark ? AppTheme.taskDarkColor : AppTheme.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewInsets.top,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const TaskBottomSheet(),
            ));
    setState(() {});
  }
}
