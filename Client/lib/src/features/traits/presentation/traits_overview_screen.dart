import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../kalinar_icons.dart';
import '../../../common_widgets/content_tab.dart';
import '../../../common_widgets/user_menu.dart';
import 'components/tabs/abilities_tab.dart';
import 'components/tabs/attributes_tab.dart';
import 'components/tabs/races_tab.dart';
import 'components/tabs/skills_tab.dart';
import 'edit_ability_screen.dart';
import 'edit_attribute_screen.dart';
import 'edit_race_screen.dart';
import 'edit_skill_screen.dart';

class TraitsOverviewScreen extends ConsumerStatefulWidget {
  static const String name = "traits";
  static const String route = "/traits";

  const TraitsOverviewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TraitsOverviewScreenState();
}

class _TraitsOverviewScreenState extends ConsumerState<TraitsOverviewScreen> with TickerProviderStateMixin {
  late final TabController controller = TabController(length: 4, vsync: this);

  void _addTrait() {
    switch (controller.index) {
      case 0:
        GoRouter.of(context).goNamed(EditAbilityScreen.name);
        break;
      case 1:
        GoRouter.of(context).goNamed(EditAttributeScreen.name);
        break;
      case 2:
        GoRouter.of(context).goNamed(EditSkillScreen.name);
        break;
      case 3:
        GoRouter.of(context).goNamed(EditRaceScreen.name);
        break;
    }
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ContentTab(
        icon: const FaIcon(Kalinar.star),
        text: AppLocalizations.of(context)!.abilities,
        content: const AbilitiesTab(),
      ),
      ContentTab(
        icon: const FaIcon(FontAwesomeIcons.tag),
        text: AppLocalizations.of(context)!.attributes,
        content: const AttributesTab(),
      ),
      ContentTab(
        icon: const FaIcon(Kalinar.skill),
        text: AppLocalizations.of(context)!.skills,
        content: const SkillsTab(),
      ),
      ContentTab(
        icon: const FaIcon(FontAwesomeIcons.person),
        text: AppLocalizations.of(context)!.races,
        content: const RacesTab(),
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
