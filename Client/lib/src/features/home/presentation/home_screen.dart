import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/layout/size.dart';
import '../../../common_widgets/user_menu.dart';
import 'home_content.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (ctx, constraints) => ScaffoldMessenger(
        child: Scaffold(
          appBar: isMobile(constraints) ? AppBar(actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())]) : null,
          body: const HomeContent(),
        ),
      ),
    );
  }
}
