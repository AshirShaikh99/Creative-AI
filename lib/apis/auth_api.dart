import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:appwrite/models.dart' as model;
import 'package:riverpod/riverpod.dart';
import 'package:social_networking/core/core.dart';

import '../core/providers.dart';

final authAPIProvider = Provider((ref) {
  final account = ref.watch(appWriteAccountProvider);
  return AuthAPI(account: account);
});

abstract class IAuthAPI {
  // IAuthAPI is an interface for AuthAPI class to implement its methods //

  FutureEither<model.User> signUp(
      {required String emailID, required String password}); // signUp method //

  FutureEither<model.Session> login({
    required String emailID,
    required String password,
  }); // login method //

  Future<model.User?> currentUserAccount(); // logout method //

  FutureEitherVoid logout(); // logout method //

}

class AuthAPI implements IAuthAPI {
  Account _account; // Account is a class from Appwrite SDK //

  AuthAPI({required Account account}) : _account = account; // Constructor //

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get(); // get is a method from Account class //
    } on AppwriteException catch (e, stackTrace) {
      return Future.error(
        Failure(e.message ?? "Error occurred",
            stackTrace), // Failure is a class from core.dart //
      );
    } catch (e, stackTrace) {
      return Future.error(
        Failure(
            e.toString(), stackTrace), // Failure is a class from core.dart //
      );
    }
  }

  @override // Overriding the signUp method from IAuthAPI interface //
  FutureEither<model.User> signUp(
      {required String emailID, required String password}) async {
    try {
      final account = await _account.create(
        userId: ID.unique(), // userId is a unique string //
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

  @override
  FutureEither<model.Session> login(
      {required String emailID, required String password}) async {
    try {
      final session = await _account.createEmailSession(
        email: emailID,
        password: password,
      );
      return right(session); // right is a function from fpdart.dart //
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? "Error occurred",
            stackTrace), // Failure is a class from core.dart //
      );
    } catch (e, stackTrace) {
      return left(
        Failure(
            e.toString(), stackTrace), // Failure is a class from core.dart //
      );
    }
    // ignore: dead_code
    throw UnimplementedError();
  }

  @override
  FutureEitherVoid logout() async {
    try {
      await _account.deleteSession(
        sessionId: 'current',
      );
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
