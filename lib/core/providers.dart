import 'package:riverpod/riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:social_networking/constants/constants.dart';

final appWriteClientProvide = Provider(
  // Provider is a class from Riverpod //
  (ref) {
    Client client = Client(); // Client is a class from Appwrite SDK //
    return client.setEndpoint(AppWriteConstants.endPoint).setProject(
        AppWriteConstants
            .projectID); // setEndpoint and setProject are methods from Client class //
  },
);
