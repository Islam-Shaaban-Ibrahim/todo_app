import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:todo_app/task_edit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings.persistenceEnabled;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SettingsProvider>(
          create: (_) => SettingsProvider()),
      ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
      ChangeNotifierProvider<AuthProviders>(create: (_) => AuthProviders()),
    ],
    child: TodoApp(),
  ));
}

// ignore: must_be_immutable
class TodoApp extends StatelessWidget {
  bool firstRun = true;

  TodoApp({super.key});
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
      home: provider.isLoggedIn ? const HomeScreen() : const LoginScreen(),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        TaskEdit.routeName: (context) => const TaskEdit(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      themeMode: provider.appTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
