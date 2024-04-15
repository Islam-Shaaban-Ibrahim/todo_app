import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  static const routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: AppTheme.backgroundColor,
        ),
        Image.asset(
          "assets/images/background.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Login",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Text("Welcome Back !",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppTheme.greyColor, fontSize: 24)),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      CustomTextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "INVALID INPUT";
                            }
                            return null;
                          },
                          label: "E-mail Address"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      CustomTextFormField(
                          obscureText: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "INVALID INPUT";
                            }
                            return null;
                          },
                          label: "Password")
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 14),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.greyColor),
                          borderRadius: BorderRadius.circular(2),
                          color: AppTheme.primaryColor),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppTheme.whiteColor,
                                        fontSize: 20)),
                            Icon(
                              Icons.arrow_forward,
                              color: AppTheme.whiteColor,
                            )
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Center(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: Text(
                      "OR CREATE AN ACCOUNT",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppTheme.greyColor, fontSize: 16),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void login() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialogUtils.showLoading(
        context: context, isDismissible: false, actionName: "Loading...");
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      MyUser? user =
          await FireBaseUtils.readUserFromFireBase(credential.user!.uid);

      if (user == null) {
        return;
      }
      final provider = Provider.of<SettingsProvider>(context, listen: false);
      provider.changeLoginStatus();
      final authProvider = Provider.of<AuthProviders>(context, listen: false);
      authProvider.changeCurrentUser(user);

      DialogUtils.hideLoading(context: context);

      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            isDismissible: false,
            context: context,
            title: "Error",
            negAction: "Cancel",
            message: 'No Internet Connection');
      } else {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            isDismissible: false,
            context: context,
            title: "Error",
            negAction: "Cancel",
            message: 'Incorrect Email or Password');
      }
    } catch (e) {
      print("${e.toString()}=======");
    }
  }
}
