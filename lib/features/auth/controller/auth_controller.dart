import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:social_networking/apis/auth_api.dart';
import 'package:social_networking/apis/user_api.dart';
import 'package:social_networking/core/utils.dart';
import 'package:social_networking/features/auth/view/login_view.dart';
import 'package:social_networking/features/home/view/home_screen.dart';
import 'package:appwrite/models.dart' as model;
import 'package:social_networking/models/user.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    // ref helps to connect with other providers ref.() //
    return AuthController(
      authAPI: ref.watch(authAPIProvider), // Watching the authAPIProvider //
      userAPI: ref.watch(userAPIProvider), // Watching the userAPIProvider //
    );
  },
);

final currentUserAccountProvider = FutureProvider<model.User?>(
  (ref) {
    final authController = ref.watch(authControllerProvider.notifier);
    return authController.currentUser();
  },
);

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI; // AuthAPI is a class from AuthAPI.dart //
  final UserAPI _userAPI; // UserAPI is a class from UserAPI.dart //
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
      : _authAPI = authAPI,
        _userAPI = userAPI,
        super(false); // Constructor //

  // If it is loading to get the final response from the Backend //

  Future<model.User?> currentUser() => _authAPI.currentUserAccount();

  void signUp({
    required String emailID,
    required String password,
    required BuildContext context,
  }) async {
    state = true; // state is true while getting the response //
    final response = await _authAPI.signUp(
        emailID: emailID,
        password: password); // signUp method from AuthAPI class //
    state = false; // state is false after getting the response //
    response.fold((l) => showSnackBar(context, l.message), (r) async {
      UserModel userModel = UserModel(
        emailID: emailID,
        name: getNameFromEmail(emailID),
        profilePic: '',
        uid: r.$id,
      ); //
      final saveResponse = await _userAPI
          .saveUserData(userModel); // saveUserData method from UserAPI class //
      saveResponse.fold(
        (l) => showSnackBar(context, l.message),
        (r) {
          showSnackBar(context, 'Account Created! Please Login');
          Navigator.push(context, LoginView.route());
        },
      );
    }); // signUp method //
  }

  void login({
    required String emailID,
    required String password,
    required BuildContext context,
  }) async {
    state = true; // state is true while getting the response //
    final response = await _authAPI.login(
        emailID: emailID,
        password: password); // login method from AuthAPI class //
    state = false; // state is false after getting the response //
    response.fold((l) => showSnackBar(context, l.message), (r) {
      Navigator.push(context, HomePage.route());
    });
  }
}
