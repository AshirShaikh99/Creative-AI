import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';
import 'package:appwrite/models.dart' as model;
import 'package:social_networking/core/core.dart';

abstract class IAuthAPI {
  // IAuthAPI is an interface for AuthAPI class to implement its methods //

  FutureEither<model.User> signUp(
      {required String emailID, required String password});
}
