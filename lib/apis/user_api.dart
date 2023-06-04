import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_networking/constants/appwrite.dart';
import 'package:social_networking/core/core.dart';
import 'package:social_networking/core/providers.dart';
import 'package:social_networking/models/user.dart';

final userAPIProvider = Provider((ref) {
  final db = ref.watch(appWriteDatabaseProvider);
  return UserAPI(db: db);
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
  Future<model.Document> getUserData(String uid);
}

class UserAPI implements IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        collectionId: AppWriteConstants.userCollectionID,
        documentId: userModel.uid,
        data: userModel.toMap(),
        databaseId: userModel.uid,
      );
      right(null);
    } on AppwriteException catch (e, str) {
      return left(
        Failure(e.message ?? 'Unexpected Error Occurred', str),
      );
    } catch (e, str) {
      left(
        Failure(e.toString(), str),
      );
    }

    throw UnimplementedError();
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppWriteConstants.databaseID,
      collectionId: AppWriteConstants.userCollectionID,
      documentId: uid,
    );
  }
}
