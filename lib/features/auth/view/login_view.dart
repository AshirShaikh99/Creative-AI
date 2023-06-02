import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_networking/apis/auth_api.dart';
import 'package:social_networking/common/loading_widget.dart';
import 'package:social_networking/constants/appwrite.dart';
import 'package:social_networking/constants/ui.dart';
import 'package:social_networking/features/auth/controller/auth_controller.dart';
import 'package:social_networking/features/auth/view/signup_view.dart';
import 'package:social_networking/features/auth/widgets/auth_button.dart';
import 'package:social_networking/features/auth/widgets/auth_fields.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_networking/theme/theme_imports.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static route() {
    return MaterialPageRoute(
      builder: (context) => const LoginView(),
    );
  }

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
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

  void login() {
    final response = ref.read(authControllerProvider.notifier).login(
          emailID: emailIDController.text,
          password: passwordController.text,
          context: context, // context is required to show snackbar
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      appBar: appBar,
      body: isLoading
          ? const LoaderWidget()
          : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Center(
                        child: Lottie.asset(
                          'assets/animation/animate.json',
                          height: 200,
                          width: 200,
                        ),
                      ),
                      AuthField(
                        controller: emailIDController,
                        hintText: "Email",
                        color: Pallete.border,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthField(
                        controller: passwordController,
                        hintText: "Password",
                        color: Pallete.border,
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: AuthButton(
                          label: "Login",
                          onPressed: () async {
                            login();
                            print("Account Found");
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, SignUpView.route());
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
