import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/presentation/auth_controller.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);

    return InkWell(
      onTap: () => state.isAuthenticated ? ref.read(authControllerProvider.notifier).signOut() : ref.read(authControllerProvider.notifier).signIn(),
      child: ListTile(
        title: Text(state.isAuthenticated ? "Sign out" : "Sign in", textAlign: TextAlign.center),
        tileColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
