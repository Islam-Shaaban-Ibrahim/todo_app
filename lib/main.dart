import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  bool firstRun = true;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    if (firstRun) {
      provider.getAllPrefs();
      firstRun = false;
    }

    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      themeMode: provider.appTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
