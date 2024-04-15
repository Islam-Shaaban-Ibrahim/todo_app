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
      home: provider.isLoggedIn ? HomeScreen() : LoginScreen(),
      //initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        TaskEdit.routeName: (context) => const TaskEdit(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      themeMode: provider.appTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
