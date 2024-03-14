import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
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
  List<Widget> tabs = [TasksTab(), SettingsTab()];

  int selectedIndex = 0;

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
          height: MediaQuery.of(context).size.height * 0.21,
          width: double.infinity,
          color: AppTheme.primaryColor,
        ),
        Scaffold(
          body: tabs[selectedIndex],
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsetsDirectional.only(start: 20),
              child: Text(
                selectedIndex == 0
                    ? AppLocalizations.of(context)!.todoList
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
                onTap: (index) {
                  selectedIndex = index;
                  setState(() {});
                },
                currentIndex: selectedIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.list_outlined,
                        size: 26,
                      ),
                      label: AppLocalizations.of(context)!.tasks),
                  BottomNavigationBarItem(
                      icon: const Icon(
                        Icons.settings,
                        size: 26,
                      ),
                      label: AppLocalizations.of(context)!.settings)
                ]),
          ),
          floatingActionButton: FloatingActionButton(
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
        )
      ],
    );
  }

  void showTaskBottomSheet() {
    var provider = Provider.of<SettingsProvider>(context, listen: false);
    showModalBottomSheet(
        backgroundColor:
            provider.isDark ? AppTheme.taskDarkColor : AppTheme.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (context) => const TaskBottomSheet());
    setState(() {});
  }
}
