import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/model/my_user.dart';
import 'package:todo_app/my_theme.dart';
import 'package:todo_app/providers/auth_provider.dart';
import 'package:todo_app/providers/settings_provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static const routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final nameController = TextEditingController();

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
              "Create Account",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.028,
                  ),
                  Column(
                    children: [
                      CustomTextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "INVALID INPUT";
                            }
                            return null;
                          },
                          label: "First Name"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
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
                        height: MediaQuery.of(context).size.height * 0.02,
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
                    height: MediaQuery.of(context).size.height * 0.11,
                  ),
                  GestureDetector(
                    onTap: () {
                      register();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 14),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.greyColor),
                          borderRadius: BorderRadius.circular(2),
                          color: AppTheme.whiteColor),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Create Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                        color: AppTheme.greyColor,
                                        fontSize: 20)),
                            const Icon(Icons.arrow_forward)
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    DialogUtils.showLoading(
        isDismissible: false, context: context, actionName: "Loading...");
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
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
          isDismissible: false,
          context: context,
          title: "Success",
          posAction: "Ok",
          posActionFunction: () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          },
          message: "Registered Successfully!");
      final authProvider = Provider.of<AuthProviders>(context, listen: false);
      authProvider.changeCurrentUser(user);
      final provider = Provider.of<SettingsProvider>(context, listen: false);
      provider.changeLoginStatus();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            isDismissible: false,
            context: context,
            title: "Error",
            negAction: "Cancel",
            message: 'The password provided is too weak.');
      } else if (e.code == 'network-request-failed') {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            isDismissible: false,
            context: context,
            title: "Error",
            negAction: "Cancel",
            message: 'No Internet Connection');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMessage(
            isDismissible: false,
            title: "Error",
            negAction: "Cancel",
            context: context,
            message: 'The account already exists for that email.');
      }
    } catch (e) {
      DialogUtils.hideLoading(context: context);
      DialogUtils.showMessage(
          isDismissible: false,
          title: "Error",
          negAction: "Cancel",
          negAtionFunction: () {},
          context: context,
          message: e.toString());
    }
  }
}
