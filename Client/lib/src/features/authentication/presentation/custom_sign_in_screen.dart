import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'auth_providers.dart';

class CustomSignInScreen extends ConsumerWidget {
  const CustomSignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);
    return Scaffold(
      body: SignInScreen(
        providers: authProviders,
        showAuthActionSwitch: true,
        headerBuilder: (context, constraints, shrinkOffset) => Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/app_icon/icon.png")),
        ),
      ),
    );
  }
}
