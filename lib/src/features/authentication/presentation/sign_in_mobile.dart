import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth_controller.dart';

class SignInMobile extends ConsumerWidget {
  const SignInMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    return ElevatedButton(
      onPressed: state.isLoading ? null : ref.read(authControllerProvider.notifier).signIn,
      child: state.isLoading ? const Center(child: CircularProgressIndicator()) : const Text("sign in"),
    );
  }
}
