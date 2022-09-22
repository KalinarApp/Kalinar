import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/presentation/auth_controller.dart';
import 'package:hero/src/utilities/async_value_extension.dart';

class AuthButton extends ConsumerWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool loginRequired = ref.watch(loginStateChangedProvider);
    final AsyncValue<void> state = ref.watch(authControllerProvider);

    ref.listen<AsyncValue>(authControllerProvider, (_, state) => state.showSnackbarOnError(context));

    return InkWell(
      onTap: () => state.isLoading
          ? null
          : loginRequired
              ? ref.read(authControllerProvider.notifier).signIn()
              : ref.read(authControllerProvider.notifier).signOut(),
      child: ListTile(
        title: state.isLoading ? const CircularProgressIndicator() : Text(loginRequired ? "Sign in" : "Sign out", textAlign: TextAlign.center),
        tileColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
