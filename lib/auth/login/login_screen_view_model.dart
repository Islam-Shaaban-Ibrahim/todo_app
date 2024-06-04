import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/login/login_navigator.dart';
import 'package:todo_app/firebase_utils.dart';

import 'package:todo_app/home_screen.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';

class LoginScreenVm extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  late LoginNavigator navigator;
  late BuildContext context;
  void login() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    navigator.showLoading();

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      MyUser? user =
          await FireBaseUtils.readUserFromFireBase(credential.user!.uid);

      if (user == null) {
        return;
      }
      // ignore: use_build_context_synchronously
      final provider = Provider.of<SettingsProvider>(context, listen: false);
      provider.changeLoginStatus();
      // ignore: use_build_context_synchronously
      final authProvider = Provider.of<AuthProviders>(context, listen: false);
      authProvider.changeCurrentUser(user);

      navigator.hideLoading();

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        navigator.hideLoading();
        navigator.showMessage('No Internet Connection');
      } else {
        navigator.hideLoading();
        navigator.showMessage('Incorrect Email or Password');
      }
    } catch (e) {
      //
    }
  }
}
