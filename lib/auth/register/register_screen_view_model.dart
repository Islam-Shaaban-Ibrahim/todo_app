import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/register/register_navigator.dart';
import 'package:todo_app/dialog_utils.dart';

class RegisterScreenVm extends ChangeNotifier {
  // todo: holds data and handles logic
  late RegisterNavigator navigator;

  void register(String email, String password) async {
    navigator.showLoading();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // MyUser user = MyUser(
      //     id: credential.user?.uid ?? '',
      //     name: nameController.text,
      //     email: emailController.text);
      // await FireBaseUtils.addUserToFireStore(user);
      navigator.hideLoading();
      navigator.showMessage("Registered Successfully!");

      // final authProvider = Provider.of<AuthProviders>(context, listen: false);
      // authProvider.changeCurrentUser(user);
      // final provider = Provider.of<SettingsProvider>(context, listen: false);
      // provider.changeLoginStatus();
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
