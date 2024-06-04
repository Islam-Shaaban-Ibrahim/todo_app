import 'package:flutter/material.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/auth/login/login_navigator.dart';
import 'package:todo_app/auth/login/login_screen_view_model.dart';
import 'package:todo_app/auth/register/register_screen.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/my_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final viewModel = LoginScreenVm();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.context = context;
  }

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
            key: viewModel.formKey,
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
                          controller: viewModel.emailController,
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
                          controller: viewModel.passwordController,
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
                      viewModel.login();
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

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showLoading() {
    DialogUtils.showLoading(
        context: context, actionName: 'Loading ....', isDismissible: false);
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(
      context: context,
      message: message,
      isDismissible: false,
      title: "Error",
      negAction: "Cancel",
    );
  }
}
