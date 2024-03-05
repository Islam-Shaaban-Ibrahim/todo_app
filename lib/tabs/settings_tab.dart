import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.dark
                  ? Color.fromARGB(255, 177, 172, 172)
                  : Colors.transparent,
              border: Border.all(color: Colors.black)),
          margin: EdgeInsetsDirectional.only(
              end: 5, start: 5, top: MediaQuery.of(context).size.height * 0.1),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListTile(
            leading: Icon(
              Icons.language,
              size: 30,
            ),
            title: Text(
              AppLocalizations.of(context)!.lang,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            ),
            trailing: DropdownMenu(
                trailingIcon: Icon(
                  Icons.arrow_drop_down,
                  size: 40,
                ),
                menuStyle: MenuStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                  provider.appTheme == ThemeMode.dark
                      ? Color.fromARGB(255, 177, 172, 172)
                      : Colors.white,
                )),
                textStyle: TextStyle(fontWeight: FontWeight.w900),
                initialSelection: provider.appLanguage,
                onSelected: (value) {
                  provider.changeLanguage(value ??= "en");
                },
                inputDecorationTheme: InputDecorationTheme(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 5)),
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                      value: "en",
                      label: AppLocalizations.of(context)!.english),
                  DropdownMenuEntry(
                      value: "ar", label: AppLocalizations.of(context)!.arabic)
                ]),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.dark
                  ? Color.fromARGB(255, 177, 172, 172)
                  : Colors.transparent,
              border: Border.all(color: Colors.black)),
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsetsDirectional.symmetric(
            vertical: 20,
            horizontal: 5,
          ),
          child: ListTile(
              leading: Icon(
                Icons.mode_night_outlined,
                size: 30,
              ),
              title: Text(
                AppLocalizations.of(context)!.dark,
                // textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
              trailing: Switch(
                value: provider.isDark,
                activeColor: AppTheme.taskDarkColor,
                onChanged: (value) {
                  if (value) {
                    provider.changeTheme(ThemeMode.dark);
                  } else {
                    provider.changeTheme(ThemeMode.light);
                  }
                  setState(() {
                    provider.isDark = value;
                  });
                },
              )),
        ),
      ],
    );
  }
}
