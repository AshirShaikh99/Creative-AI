import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_networking/features/auth/controller/auth_controller.dart';
import 'package:social_networking/theme/theme_imports.dart';

import '../../../core/utils.dart';

class UserName extends ConsumerWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserAccountProvider);
    return Text(
      "Hi ${getNameFromEmail(currentUser.value!.email)}, I am your creative AI, How can I help you?",
      style: TextStyle(
        color: Pallete.border,
        fontSize: 20,
        fontFamily: 'Rubik',
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
