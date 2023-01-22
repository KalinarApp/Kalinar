import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/user_menu.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = "Home";
  static const String route = "/home";

  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final bool hasGroup;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildHomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)!.workInProgress),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: UserMenu(),
        ),
      ]),
      body: _buildHomeScreen(),
    );
  }
}
