import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/user_menu.dart';
import '../../../constants/breakpoints.dart';
import 'home_content.dart';

class HomeScreen extends ConsumerWidget {
  final String? inviteCode;

  const HomeScreen({super.key, this.inviteCode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (ctx, constraints) => ScaffoldMessenger(
        child: Scaffold(
          appBar: constraints.maxWidth < Breakpoint.mobile
              ? AppBar(actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())])
              : null,
          body: const HomeContent(),
        ),
      ),
    );
  }
}
