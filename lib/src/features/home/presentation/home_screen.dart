import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/user_menu.dart';
import 'package:hero/src/features/group_management/presentation/user_invite_screen.dart';

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
        children: const [
          Text("Baustelle, bitte nicht weiter gehen!"),
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
