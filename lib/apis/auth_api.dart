import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:appwrite/models.dart' as model;
import 'package:social_networking/core/core.dart';

abstract class IAuthAPI {
  // IAuthAPI is an interface for AuthAPI class to implement its methods //

  FutureEither<model.User> signUp(
      {required String emailID, required String password}); // signUp method //
}

class AuthAPI implements IAuthAPI {
  Account _account; // Account is a class from Appwrite SDK //

  AuthAPI({required Account account}) : _account = account; // Constructor //

  @override // Overriding the signUp method from IAuthAPI interface //
  FutureEither<model.User> signUp(
      {required String emailID, required String password}) async {
    try {
      _account.create(
        userId: 'unique()',
        email: emailID,
        password: password,
      );
    } catch (e) {}
  }
}
