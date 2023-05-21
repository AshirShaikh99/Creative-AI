import 'package:riverpod/riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:social_networking/constants/constants.dart';

final appWriteClientProvider = Provider(
  // Provider is a class from Riverpod //
  (ref) {
    Client client = Client(); // Client is a class from Appwrite SDK //
    return client
        .setEndpoint(AppWriteConstants.endPoint)
        .setProject(AppWriteConstants.projectID)
        .setSelfSigned(status: true); // Setting up Appwrite client //
  },
);

final appWriteAccountProvider = Provider(
  (ref) {
    final client = ref.watch(appWriteClientProvider); // Watching the client //
    return Account(client); // Account is a class from Appwrite SDK //
  },
);
