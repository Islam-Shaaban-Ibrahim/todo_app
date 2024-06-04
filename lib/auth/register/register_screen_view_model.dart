// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/register/register_navigator.dart';

import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';

class RegisterScreenVm extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final passwordController = TextEditingController();
  // todo: holds data and handles logic
  late RegisterNavigator navigator;
  late BuildContext context;
  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    navigator.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      MyUser user = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text);
      await FireBaseUtils.addUserToFireStore(user);

      final authProvider = Provider.of<AuthProviders>(context, listen: false);
      authProvider.changeCurrentUser(user);
      final provider = Provider.of<SettingsProvider>(context, listen: false);
      provider.changeLoginStatus();
      navigator.hideLoading();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideLoading();
        navigator.showMessage('The password provided is too weak.');
      } else if (e.code == 'network-request-failed') {
        navigator.hideLoading();
        navigator.showMessage('No Internet Connection');
      } else if (e.code == 'email-already-in-use') {
        navigator.hideLoading();
        navigator.showMessage('The account already exists for that email.');
      }
    } catch (e) {
      navigator.hideLoading();
      navigator.showMessage(e.toString());
    }
  }
}
