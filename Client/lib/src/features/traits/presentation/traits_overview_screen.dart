import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/content_tab.dart';
import '../../../common_widgets/user_menu.dart';
import 'components/abilities_tab.dart';
import 'edit_ability_screen.dart';

class TraitsOverviewScreen extends ConsumerStatefulWidget {
  static const String name = "traits";
  static const String route = "/traits";

  const TraitsOverviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TraitsOverviewScreenState();
}

class _TraitsOverviewScreenState extends ConsumerState<TraitsOverviewScreen> with TickerProviderStateMixin {
  late final TabController controller = TabController(length: 1, vsync: this);

  void _addTrait() {
    switch (controller.index) {
      case 0:
        GoRouter.of(context).goNamed(EditAbilityScreen.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ContentTab(
        icon: const FaIcon(FontAwesomeIcons.award),
        text: AppLocalizations.of(context)!.abilities,
        content: const AbilitiesTab(),
      )
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: _addTrait, child: const Icon(Icons.add)),
      appBar: AppBar(
        actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())],
        bottom: TabBar(tabs: tabs, controller: controller),
      ),
      body: TabBarView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        children: tabs.map((e) => e.content).toList(),
      ),
    );
  }
}
