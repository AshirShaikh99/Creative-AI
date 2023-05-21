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
      final account = await _account.create(
        userId: 'unique()', // userId is a unique string //
        email: emailID, // email is a string //
        password: password, // password is a string //
      ); // create is a method from Account class //
      return right(account); // right is a function from fpdart.dart //
    } on AppwriteException catch (e, stackTrace) {
      // AppwriteException is a class from Appwrite SDK //
      // Catching errors and stack trace //
      return left(
        Failure(e.message ?? "Error occurred",
            stackTrace), // Failure is a class from core.dart //
      );
    } catch (e, stackTrace) {
      // Catching errors and stack trace //
      return left(
        Failure(
            e.toString(), stackTrace), // Failure is a class from core.dart //
      );
    }
  }
}
