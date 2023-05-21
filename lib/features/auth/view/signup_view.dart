import 'package:flutter/material.dart';

import '../../../constants/ui.dart';
import '../widgets/auth_fields.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailIDController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final appBar = UIConstants.appBar();

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
                ],
              ),
            ),
          ),
        ));
  }
}
