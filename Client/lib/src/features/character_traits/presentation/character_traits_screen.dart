import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/features/character_traits/application/search_controller.dart';

import '../../../common_widgets/no_animation_tab_bar_view.dart';
import '../../../utils/build_context_extensions.dart';

class CharacterTraitsScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<Widget> children;

  const CharacterTraitsScreen({super.key, required this.navigationShell, required this.children});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterTraitsScreenState();
}

class _CharacterTraitsScreenState extends ConsumerState<CharacterTraitsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 2, vsync: this, initialIndex: widget.navigationShell.currentIndex);

  @override
  void initState() {
    super.initState();
  }

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
    return LayoutBuilder(
      builder: (ctx, constraints) => Scaffold(
        appBar: AppBarWithSearchSwitch(
          onChanged: (value) => ref.watch(searchControllerProvider.notifier).search(value),
          fieldHintText: AppLocalizations.of(context)!.search,
          appBarBuilder: (context) => AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: const [AppBarSearchButton()],
            title: TabBar(
              tabs: [
                Tab(text: context.localizations.abilities),
                Tab(text: context.localizations.attributes),
              ],
              isScrollable: false,
              padding: const EdgeInsets.symmetric(vertical: 10),
              controller: _tabController,
              tabAlignment: TabAlignment.center,
              onTap: _onTabTapped,
            ),
          ),
        ),
        body: NoAnimationTabBarView(controller: _tabController, children: widget.children),
      ),
    );
  }
}
