import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kalinar/src/features/characters/presentation/components/details/character_abilities.dart';

import '../../../common_widgets/loading_indicator.dart';
import '../application/character_controller.dart';
import '../domain/character.dart';

import 'components/details/character_sheet_widget.dart';
import 'components/details/character_skilltree_list.dart';

class CharacterDetailScreen extends ConsumerStatefulWidget {
  static const String name = "CharacterDetail";
  static const String route = ":id";

  final String id;

  const CharacterDetailScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterDetailScreenState();
}

Widget _buildContent(BuildContext context, AsyncSnapshot<Character> snapshot) {
  if (!snapshot.hasData) return Center(child: LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter));
  final character = snapshot.data as Character;

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: TabBarView(children: [
      CharacterSheetWidget(character),
      CharacterAbilities(character),
      CharacterSkilltreeList(character),
    ]),
  );
}

class _CharacterDetailScreenState extends ConsumerState<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(characterControllerProvider).getById(widget.id),
      builder: (context, snapshot) {
        final List<Widget> tabs = [
          Tab(icon: const FaIcon(FontAwesomeIcons.person), text: AppLocalizations.of(context)!.characteristics),
          Tab(icon: const FaIcon(FontAwesomeIcons.award), text: AppLocalizations.of(context)!.abilities),
          Tab(icon: const FaIcon(FontAwesomeIcons.circleNodes), text: AppLocalizations.of(context)!.skilltrees),
        ];

        return DefaultTabController(
          length: tabs.length,
          initialIndex: 0,
          child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(tabs: tabs),
              ),
              body: _buildContent(context, snapshot)),
        );
      },
    );
  }
}
