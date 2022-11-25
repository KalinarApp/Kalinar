import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth_controller.dart';

class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);

    return InkWell(
      onTap: state.isLoading ? null : ref.read(authControllerProvider.notifier).signOut,
      child: ListTile(
        title: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Text(AppLocalizations.of(context)!.logout, textAlign: TextAlign.center),
        tileColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
