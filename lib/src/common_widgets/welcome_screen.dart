import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/navigation/app_drawer.dart';
import 'package:hero/src/utilities/hero_api.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authChangedProvider);
    return Scaffold(
      appBar: AppBar(),
      drawer: authState.maybeWhen(data: (state) => AppDrawer(isAuthenticated: state.isAuthenticated), orElse: () => null),
      body: Container(),
    );
  }
}
