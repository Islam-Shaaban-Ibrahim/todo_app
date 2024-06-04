import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';

import 'package:todo_app/model/my_user.dart';

class AuthProviders extends ChangeNotifier {
  MyUser? currentUser = FireBaseUtils.getCurrentUser();
  void changeCurrentUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
