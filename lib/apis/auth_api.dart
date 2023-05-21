import 'package:appwrite/appwrite.dart';
import 'package:fpdart/fpdart.dart';

abstract class IAuthAPI {
  // IAuthAPI is an interface for AuthAPI class to implement its methods //

  Future<Either<String, Account>> signUp();
}

class AuthAPI implements IAuthAPI {
  @override
  Future<Either<String, Account>> signUp() {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
