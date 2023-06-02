import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:social_networking/apis/auth_api.dart';
import 'package:social_networking/common/loading_widget.dart';
import 'package:social_networking/features/auth/controller/auth_controller.dart';
import 'package:social_networking/features/auth/view/login_view.dart';
import 'package:social_networking/features/auth/widgets/auth_button.dart';
import 'package:social_networking/theme/theme_imports.dart';
import '../../../constants/ui.dart';
import '../widgets/auth_fields.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) => const SignUpView(),
    );
  }

  const SignUpView({Key? key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
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

  void signUp() {
    final response = ref.read(authControllerProvider.notifier).signUp(
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
                        child: AuthButton(
                          label: "Sign Up",
                          onPressed: signUp,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rubik',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, LoginView.route());
                            },
                            child: const Text(
                              "Login",
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
