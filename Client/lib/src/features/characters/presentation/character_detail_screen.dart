import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../kalinar_icons.dart';
import '../../../common_widgets/content_tab.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../../../utilities/async_value_extension.dart';
import '../../group_management/application/group_notifier.dart';
import '../../inventory/presentation/inventory_list.dart';
import '../application/controllers/character_controller.dart';
import '../application/notifier/character_state_notifier.dart';
import '../domain/character.dart';
import 'components/details/auto_saving_text_field.dart';
import 'components/details/character_abilities.dart';
import 'components/details/character_configuration.dart';
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

    final List<ContentTab> tabs = [
      ContentTab(
        icon: const Icon(Kalinar.characteristics),
        text: AppLocalizations.of(context)!.characteristics,
        content: CharacterSheetWidget(state),
      ),
      if (_isOwnerOrAdmin(state) || (state.shareAbilities ?? false))
        ContentTab(
          icon: const Icon(Kalinar.star),
          text: AppLocalizations.of(context)!.abilities,
          content: CharacterAbilities(state),
        ),
      if (_isOwnerOrAdmin(state) || (state.shareSkilltree ?? false))
        ContentTab(
          icon: const Icon(Kalinar.node),
          text: AppLocalizations.of(context)!.skilltrees,
          content: CharacterSkilltreeList(state),
        ),
      if (_isOwnerOrAdmin(state) || (state.shareInventory ?? false))
        ContentTab(
          icon: const Icon(Kalinar.backpack),
          text: AppLocalizations.of(context)!.characterInventory,
          content: const InventoryList(),
          // content: Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: AutoSavingTextField(
          //     title: AppLocalizations.of(context)!.characterInventory,
          //     initialValue: state.inventory,
          //     minLines: null,
          //     maxLines: null,
          //     expands: true,
          //     enabled: _isOwner(state),
          //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          //     onSaving: (currentText) async => await _saveField("inventory", currentText),
          //   ),
          // ),
        ),
      if (_isOwnerOrAdmin(state) || (state.shareNotes ?? false))
        ContentTab(
          icon: const Icon(Kalinar.note),
          text: AppLocalizations.of(context)!.characterNotes,
          content: Padding(
            padding: const EdgeInsets.all(12.0),
            child: AutoSavingTextField(
              title: AppLocalizations.of(context)!.characterNotes,
              initialValue: state.notes,
              minLines: null,
              maxLines: null,
              expands: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              enabled: _isOwner(state),
              onSaving: (currentText) async => await _saveField("notes", currentText),
            ),
          ),
        ),
      if (_isOwner(state))
        ContentTab(
          icon: const FaIcon(Icons.settings),
          text: AppLocalizations.of(context)!.settings,
          content: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CharacterConfiguration(state, save: _saveField),
          ),
        )
    ];

    return KeyboardDismisser(
      child: DefaultTabController(
        length: tabs.length,
        initialIndex: 0,
        child: Builder(
          builder: (ctx) {
            final controller = DefaultTabController.of(ctx);
            controller.addListener(() {
              FocusManager.instance.primaryFocus?.unfocus();
            });

            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshCharacter),
                ],
                bottom: 1 < tabs.length ? TabBar(tabs: tabs, isScrollable: true) : null,
              ),
              body: 1 < tabs.length
                  ? NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (OverscrollIndicatorNotification overScroll) {
                        overScroll.disallowIndicator();
                        return false;
                      },
                      child: TabBarView(children: [...tabs.map((e) => e.content)]))
                  : tabs.first.content,
            );
          },
        ),
      ),
    );
  }
}
