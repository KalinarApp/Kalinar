import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kalinar/src/features/characters/presentation/components/details/character_abilities.dart';
import 'package:kalinar/src/features/characters/presentation/components/details/character_tab.dart';

import '../../../common_widgets/loading_indicator.dart';
import '../application/character_controller.dart';
import '../domain/character.dart';

import 'components/details/auto_saving_text_field.dart';
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

class _CharacterDetailScreenState extends ConsumerState<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(characterControllerProvider).getById(widget.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter));

        final List<CharacterTab> tabs = [
          CharacterTab(
            icon: const FaIcon(FontAwesomeIcons.person),
            text: AppLocalizations.of(context)!.characteristics,
            tab: CharacterSheetWidget(snapshot.data!),
          ),
          CharacterTab(
            icon: const FaIcon(FontAwesomeIcons.award),
            text: AppLocalizations.of(context)!.abilities,
            tab: CharacterAbilities(snapshot.data!),
          ),
          CharacterTab(
            icon: const FaIcon(FontAwesomeIcons.circleNodes),
            text: AppLocalizations.of(context)!.skilltrees,
            tab: CharacterSkilltreeList(snapshot.data!),
          ),
          CharacterTab(
            icon: const FaIcon(FontAwesomeIcons.clipboardCheck),
            text: AppLocalizations.of(context)!.characterInventory,
            tab: SingleChildScrollView(
              child: Column(
                children: [
                  AutoSavingTextField(
                    title: AppLocalizations.of(context)!.characterInventory,
                    initialValue: snapshot.data!.inventory,
                    minLines: 1,
                    maxLines: 2000000000,
                    onSaving: (currentText) async =>
                        await ref.read(characterControllerProvider).update(snapshot.data!.id, {"inventory": currentText}),
                  ),
                ],
              ),
            ),
          ),
          CharacterTab(
            icon: const FaIcon(FontAwesomeIcons.noteSticky),
            text: AppLocalizations.of(context)!.characterNotes,
            tab: SingleChildScrollView(
              child: Column(
                children: [
                  AutoSavingTextField(
                    title: AppLocalizations.of(context)!.characterNotes,
                    initialValue: snapshot.data!.notes,
                    minLines: 1,
                    maxLines: 2000000000,
                    onSaving: (currentText) async => await ref.read(characterControllerProvider).update(snapshot.data!.id, {"notes": currentText}),
                  ),
                ],
              ),
            ),
          ),
        ];

        return DefaultTabController(
          length: tabs.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(tabs: tabs, isScrollable: true),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TabBarView(
                children: [...tabs.map((e) => e.tab)],
              ),
            ),
          ),
        );
      },
    );
  }
}
