import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/auth/custom_text_form_field.dart';
import 'package:todo_app/auth/register/register_navigator.dart';
import 'package:todo_app/auth/register/register_screen_view_model.dart';
import 'package:todo_app/dialog_utils.dart';
import 'package:todo_app/my_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  final viewModel = RegisterScreenVm();
  @override
  void initState() {
    viewModel.navigator = this;
    viewModel.context = context;
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
              key: viewModel.formKey,
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
                            controller: viewModel.nameController,
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
                            controller: viewModel.emailController,
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
                      height: MediaQuery.of(context).size.height * 0.11,
                    ),
                    GestureDetector(
                      onTap: () {
                        viewModel.register();
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

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showLoading() {
    DialogUtils.showLoading(
        context: context, actionName: 'Loading.....', isDismissible: false);
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
