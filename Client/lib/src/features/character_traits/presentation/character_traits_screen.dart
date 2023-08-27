import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/content_tab.dart';
import '../../../common_widgets/no_animation_tab_bar_view.dart';

class CharacterTraitsScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const CharacterTraitsScreen({super.key, required this.navigationShell});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterTraitsScreenState();
}

class _CharacterTraitsScreenState extends ConsumerState<CharacterTraitsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this, initialIndex: widget.navigationShell.currentIndex);

  @override
  void didUpdateWidget(covariant CharacterTraitsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _tabController.index = widget.navigationShell.currentIndex;
  }

  void _onTabTapped(int index) {
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ContentTab(
        // icon: const FaIcon(Kalinar.star, size: 18),
        text: AppLocalizations.of(context)!.abilities,
        content: const Text("Abilties"),
      ),
      ContentTab(
        // icon: const FaIcon(FontAwesomeIcons.tag, size: 18),
        text: AppLocalizations.of(context)!.attributes,
        content: const Text("Attributes"),
      ),
      // ContentTab(
      //   icon: const FaIcon(Kalinar.skill),
      //   text: AppLocalizations.of(context)!.skills,
      //   content: const Text("Skills"),
      // ),
      // ContentTab(
      //   icon: const FaIcon(FontAwesomeIcons.person),
      //   text: AppLocalizations.of(context)!.races,
      //   content: const Text("Races"),
      // )
    ];

    return LayoutBuilder(
      builder: (ctx, constraints) => Scaffold(
        appBar: AppBarWithSearchSwitch(
          onChanged: (_) {},
          fieldHintText: AppLocalizations.of(context)!.search,
          
          appBarBuilder: (context) => AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [AppBarSearchButton()],
            title: TabBar(
              tabs: tabs,
              isScrollable: false,
              padding: const EdgeInsets.symmetric(vertical: 10),
              controller: _tabController,
              tabAlignment: TabAlignment.center,
              onTap: _onTabTapped,
            ),
          ),
        ),
        body: NoAnimationTabBarView(controller: _tabController, children: tabs.map((e) => e.content).toList()),
      ),
    );
  }
}
