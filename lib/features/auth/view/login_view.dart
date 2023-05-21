import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:social_networking/apis/auth_api.dart';
import 'package:social_networking/constants/appwrite.dart';
import 'package:social_networking/constants/ui.dart';
import 'package:social_networking/features/auth/widgets/auth_button.dart';
import 'package:social_networking/features/auth/widgets/auth_fields.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final appBar = UIConstants.appBar();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailIDController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AuthField(
                  controller: emailIDController,
                  hintText: "Email",
                ),
                const SizedBox(
                  height: 20,
                ),
                AuthField(
                  controller: passwordController,
                  hintText: "Password",
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: AuthButton(
                    label: "Login",
                    onPressed: () async {
                      print("Account Found");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
