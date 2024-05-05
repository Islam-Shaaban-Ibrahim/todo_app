import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/auth/register/register_navigator.dart';
import 'package:todo_app/auth/register/register_screen_view_model.dart';
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

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final passwordController = TextEditingController();
  final viewModel = RegisterScreenVm();
  @override
  void initState() {
    // TODO: implement initState
    viewModel.navigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
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
      ),
    );
  }

  void register() async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    viewModel.register(emailController.text, passwordController.text);
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showLoading() {
    DialogUtils.showLoading(context: context, actionName: 'Loading.....');
  }

  @override
  void showMessage(String message) {
    DialogUtils.showMessage(context: context, message: message);
  }
}
