import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_networking/features/auth/controller/auth_controller.dart';
import 'package:social_networking/theme/theme_imports.dart';

class Logout extends ConsumerWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        ref.read(authControllerProvider.notifier).logout(context);
      },
      icon: const Icon(
        Icons.logout,
        color: Pallete.border,
      ),
    );
  }
}
