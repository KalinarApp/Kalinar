import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../common_widgets/loading_indicator.dart';
import '../../../utilities/async_value_extension.dart';
import '../../group_management/application/group_notifier.dart';
import '../application/controllers/character_controller.dart';
import '../application/notifier/character_state_notifier.dart';
import '../domain/character.dart';
import 'components/details/auto_saving_text_field.dart';
import 'components/details/character_abilities.dart';
import 'components/details/character_configuration.dart';
import 'components/details/character_sheet_widget.dart';
import 'components/details/character_skilltree_list.dart';
import 'components/details/character_tab.dart';

class CharacterDetailScreen extends ConsumerStatefulWidget {
  static const String name = "CharacterDetail";
  static const String route = ":id";

  final String id;

  const CharacterDetailScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends ConsumerState<CharacterDetailScreen> {

  bool _isOwner(Character character) {
    return FirebaseAuth.instance.currentUser?.uid == character.userId;
  }

  bool _isOwnerOrAdmin(Character character) {
    return _isOwner(character) || ref.read(groupNotifierProvider).group?.ownerId == FirebaseAuth.instance.currentUser?.uid;
  }

  Future _saveField(String fieldName, dynamic value) async {
    final state = await ref.read(characterControllerProvider).update(widget.id, {fieldName: value});
    if (!mounted) return;
    state.showSnackbarOnError(context);
  }

  _refreshCharacter() async {
    final value = await ref.read(characterControllerProvider).get(widget.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(characterStateProvider);

    if (null == state) {
      return LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter);
    }

    final List<CharacterTab> tabs = [
      CharacterTab(
        icon: const FaIcon(FontAwesomeIcons.person),
        text: AppLocalizations.of(context)!.characteristics,
        tab: CharacterSheetWidget(state),
      ),
      if (_isOwnerOrAdmin(state) || (state.shareAbilities ?? false))
        CharacterTab(
          icon: const FaIcon(FontAwesomeIcons.award),
          text: AppLocalizations.of(context)!.abilities,
          tab: CharacterAbilities(state),
        ),
      if (_isOwnerOrAdmin(state) || (state.shareSkilltree ?? false))
        CharacterTab(
          icon: const FaIcon(FontAwesomeIcons.circleNodes),
          text: AppLocalizations.of(context)!.skilltrees,
          tab: CharacterSkilltreeList(state),
        ),
      if (_isOwnerOrAdmin(state) || (state.shareInventory ?? false))
        CharacterTab(
          icon: const FaIcon(FontAwesomeIcons.clipboardCheck),
          text: AppLocalizations.of(context)!.characterInventory,
          tab: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                AutoSavingTextField(
                  title: AppLocalizations.of(context)!.characterInventory,
                  initialValue: state.inventory,
                  minLines: 1,
                  maxLines: 2000000000,
                  enabled: _isOwner(state),
                  onSaving: (currentText) async => await _saveField("inventory", currentText),
                ),
              ],
            ),
          ),
        ),
      if (_isOwnerOrAdmin(state) || (state.shareNotes ?? false))
        CharacterTab(
          icon: const FaIcon(FontAwesomeIcons.noteSticky),
          text: AppLocalizations.of(context)!.characterNotes,
          tab: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AutoSavingTextField(
                    title: AppLocalizations.of(context)!.characterNotes,
                    initialValue: state.notes,
                    minLines: 1,
                    maxLines: 2000000000,
                    enabled: _isOwner(state),
                    onSaving: (currentText) async => await _saveField("notes", currentText),
                  ),
                ],
              ),
            ),
          ),
        ),
      if (_isOwner(state))
        CharacterTab(
          icon: const FaIcon(Icons.settings),
          text: AppLocalizations.of(context)!.settings,
          tab: CharacterConfiguration(state, save: _saveField),
        )
    ];

    return DefaultTabController(
      length: tabs.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: 1 < tabs.length ? TabBar(tabs: tabs, isScrollable: true) : null,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: 1 < tabs.length
              ? TabBarView(
                  children: [...tabs.map((e) => e.tab)],
                )
              : tabs.first.tab,
        ),
      ),
    );
  }
}
