import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/presentation/auth_controller.dart';
import 'package:hero/src/utilities/hero_api.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authChangedProvider);

    return authState.when(
        data: (state) {
          final title = state.isAuthenticated ? "sign out" : "sign in";
          final onTab = state.isAuthenticated ? ref.read(authControllerProvider).signOut : ref.read(authControllerProvider).signIn;

          return InkWell(
            onTap: onTab,
            child: ListTile(
              title: Text(title, textAlign: TextAlign.center),
              tileColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
        error: (error, stackTrace) => ListTile(title: const Icon(Icons.error), tileColor: Theme.of(context).colorScheme.error),
        loading: () =>
            ListTile(title: const Center(child: CircularProgressIndicator(color: Colors.white)), tileColor: Theme.of(context).colorScheme.primary));
  }
}
