import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/presentation/auth_controller.dart';
import 'package:hero/src/utilities/hero_api.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authChangedProvider);

    return authState.maybeWhen(
        data: (isAuthenticated) {
          final title = isAuthenticated ? "sign out" : "sign in";
          final onTab = isAuthenticated ? ref.read(authControllerProvider.notifier).signOut : ref.read(authControllerProvider.notifier).signIn;

          return InkWell(
            onTap: onTab,
            child: ListTile(
              title: Text(title, textAlign: TextAlign.center),
              tileColor: Theme.of(context).colorScheme.primary,
            ),
          );
        },
        orElse: () => const ListTile(title: CircularProgressIndicator()));
  }
}
