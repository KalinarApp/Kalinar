import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/common_widgets/layout/responsive_layout.dart';
import 'package:kalinar/src/common_widgets/loading_indicator.dart';

import '../../../common_widgets/content_tab.dart';
import '../application/controllers/character_overview_controller.dart';
import '../application/notifier/character_overview_state_notifier.dart';
import 'character_editor_dialog.dart';
import 'shared/character_overview_tab.dart';

class CharacterOverviewScreen extends ConsumerStatefulWidget {
  static const String name = "CharacterOverview";
  static const String route = "/characters";

  const CharacterOverviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterOverviewScreenState();
}

class _CharacterOverviewScreenState extends ConsumerState<CharacterOverviewScreen> with TickerProviderStateMixin {
  bool canAdd = true;
  late final _controller = TabController(length: 2, vsync: this);

  @override
  void initState() {
    _controller.addListener(() => setState(() => canAdd = _controller.index == 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ContentTab(
        text: AppLocalizations.of(context)!.ownCharacters,
        content: CharacterOverviewTab(
          controller: ref.watch(ownedCharactersProvider),
          items: ref.watch(ownedCharactersStateProvider),
          canInteract: true,
        ),
      ),
      ContentTab(
        text: AppLocalizations.of(context)!.otherCharacters,
        content: CharacterOverviewTab(
          controller: ref.watch(foreignCharactersProvider),
          items: ref.watch(foreignCharactersStateProvider),
        ),
      ),
    ];

    return ResponsiveLayout(
      desktop: const Scaffold(body: LoadingIndicator("")),
      mobile: Scaffold(
        floatingActionButton: canAdd ? FloatingActionButton(onPressed: () => showCharacterEditorDialog(context), child: const Icon(Icons.add)) : null,
        appBar: AppBar(
          bottom: TabBar(tabs: tabs, controller: _controller),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: TabBarView(controller: _controller, children: tabs.map((e) => e.content).toList()),
        ),
      ),
    );
  }
}
