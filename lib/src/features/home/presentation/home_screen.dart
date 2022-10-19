import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/user_menu.dart';
import 'package:hero/src/features/group_management/application/group_controller.dart';
import 'package:hero/src/features/group_management/presentation/join_group.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = "Home";
  static const String route = "home";

  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final bool hasGroup;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => ref.refresh(hasGroupProvider));
    super.initState();
  }

  Widget _buildHomeScreen() {
    return const Center(child: Text("Baustelle, bitte nicht weiter gehen!"));
  }

  Widget _buildNoGroupScreen() {
    return const NoGroupScreen();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hasGroupProvider);

    return Scaffold(
        appBar: AppBar(actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: UserMenu(),
          ),
        ]),
        body: state.when(
          data: (data) => data ? _buildHomeScreen() : _buildNoGroupScreen(),
          error: (error, stackTrace) => const Center(child: Text("Fehler beim Laden der Benutzerinformationen.")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ));
  }
}
