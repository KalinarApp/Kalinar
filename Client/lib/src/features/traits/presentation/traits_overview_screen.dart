import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common_widgets/content_tab.dart';
import '../../../common_widgets/user_menu.dart';
import 'components/abilities_tab.dart';

class TraitsOverviewScreen extends ConsumerStatefulWidget {
  static const String name = "traits";
  static const String route = "/traits";

  const TraitsOverviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TraitsOverviewScreenState();
}

class _TraitsOverviewScreenState extends ConsumerState<TraitsOverviewScreen> with TickerProviderStateMixin {
  late final TabController controller;
  late final List<ContentTab> tabs;

  @override
  void didChangeDependencies() {
    tabs = [
      ContentTab(
        icon: const FaIcon(FontAwesomeIcons.award),
        text: AppLocalizations.of(context)!.abilities,
        content: const AbilitiesTab(),
      )
    ];

    controller = TabController(length: tabs.length, vsync: this);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      appBar: AppBar(
        actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())],
        bottom: TabBar(tabs: tabs, controller: controller),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TabBarView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          children: tabs.map((e) => e.content).toList(),
        ),
      ),
    );
  }
}
