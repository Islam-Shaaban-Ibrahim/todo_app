import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/login/login_navigator.dart';

import 'package:todo_app/home_screen.dart';

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

      // MyUser? user =
      //     await FireBaseUtils.readUserFromFireBase(credential.user!.uid);

      // if (user == null) {
      //   return;
      // }
      // final provider = Provider.of<SettingsProvider>(context, listen: false);
      // provider.changeLoginStatus();
      // final authProvider = Provider.of<AuthProviders>(context, listen: false);
      // authProvider.changeCurrentUser(user);

      navigator.hideLoading();

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        navigator.hideLoading();
        navigator.showMessage('No Internet Connection');
        // DialogUtils.showMessage(
        //     isDismissible: false,
        //     context: context,
        //     title: "Error",
        //     negAction: "Cancel",
        //     message: 'No Internet Connection');
      } else {
        navigator.hideLoading();
        navigator.showMessage('Incorrect Email or Password');
        // DialogUtils.showMessage(
        //     isDismissible: false,
        //     context: context,
        //     title: "Error",
        //     negAction: "Cancel",
        //     message: 'Incorrect Email or Password');
      }
    } catch (e) {
      print("${e.toString()}=======");
    }
  }
}
