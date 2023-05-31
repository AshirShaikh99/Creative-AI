import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:social_networking/apis/auth_api.dart';
import 'package:social_networking/common/loading_widget.dart';
import 'package:social_networking/constants/appwrite.dart';
import 'package:social_networking/constants/ui.dart';
import 'package:social_networking/features/auth/controller/auth_controller.dart';
import 'package:social_networking/features/auth/widgets/auth_button.dart';
import 'package:social_networking/features/auth/widgets/auth_fields.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: appBar,
      body: isLoading
          ? const LoaderWidget()
          : Center(
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
                            login();
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
