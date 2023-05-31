import 'package:social_networking/core/core.dart';

abstract class IUserAPI {
  FutureEitherVoid saveUserData();
}

class UserAPI implements IUserAPI {
  @override
  FutureEitherVoid saveUserData() {
    // TODO: implement saveUserData
    throw UnimplementedError();
  }
}
