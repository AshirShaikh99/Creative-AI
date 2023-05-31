// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_networking/common/error_screen.dart';
import 'package:social_networking/common/loading_widget.dart';
import 'package:social_networking/features/auth/controller/auth_controller.dart';
import 'package:social_networking/features/auth/view/login_view.dart';
import 'package:social_networking/features/auth/view/signup_view.dart';
import 'package:social_networking/features/home/view/home_screen.dart';
import 'package:social_networking/theme/theme_imports.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Networking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}


// Use it later // 

// ref.watch(currentUserAccountProvider).when(
//             data: (user) {
//               if (user != null) {
//                 return const HomeScreen();
//               } else {
//                 return const SignUpView();
//               }
//             },
//             error: (error, str) => Error(
//               error: error.toString(),
//             ),
//             loading: () => const LoadingScreen(),
//           ), 