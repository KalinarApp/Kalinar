import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalinar/src/features/characters/presentation/shared/details/notes_text_field.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../../kalinar_icons.dart';
import '../../../../common_widgets/content_tab.dart';
import '../../../../common_widgets/loading_indicator.dart';
import '../../../../utilities/async_value_extension.dart';
import '../../../group_management/application/group_notifier.dart';
import '../../application/controllers/character_controller.dart';
import '../../domain/character.dart';
import '../shared/details/character_abilities.dart';
import '../shared/details/character_configuration.dart';
import '../shared/details/character_skilltree_list.dart';
import '../shared/details/inventory_text_field.dart';
import 'components/character_data.dart';

class CharacterScreen extends ConsumerStatefulWidget {
  final Character? item;

  const CharacterScreen(this.item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends ConsumerState<CharacterScreen> {
  bool _isOwner(Character character) {
    return FirebaseAuth.instance.currentUser?.uid == character.userId;
  }

  bool _isOwnerOrAdmin(Character character) {
    return _isOwner(character) || ref.read(groupNotifierProvider).group?.ownerId == FirebaseAuth.instance.currentUser?.uid;
  }

  Future _saveField(String fieldName, dynamic value) async {
    final state = await ref.read(characterControllerProvider).update(widget.item!.id, {fieldName: value});
    if (!mounted) return;
    state.showSnackbarOnError(context);
  }

  _refreshCharacter() async {
    final value = await ref.read(characterControllerProvider).get(widget.item!.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  @override
  Widget build(BuildContext context) {
    if (null == widget.item) {
      return LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter);
    }

    final item = widget.item!;

    final List<ContentTab> tabs = [
      ContentTab(
        icon: const Icon(Kalinar.characteristics),
        text: AppLocalizations.of(context)!.characteristics,
        content: CharacterData(item),
      ),
      if (_isOwnerOrAdmin(item) || (item.shareAbilities ?? false))
        ContentTab(
          icon: const Icon(Kalinar.star),
          text: AppLocalizations.of(context)!.abilities,
          content: CharacterAbilities(item),
        ),
      if (_isOwnerOrAdmin(item) || (item.shareSkilltree ?? false))
        ContentTab(
          icon: const Icon(Kalinar.node),
          text: AppLocalizations.of(context)!.skilltrees,
          content: CharacterSkilltreeList(item),
        ),
      if (_isOwnerOrAdmin(item) || (item.shareInventory ?? false))
        ContentTab(
          icon: const Icon(Kalinar.backpack),
          text: AppLocalizations.of(context)!.characterInventory,
          content: Padding(padding: const EdgeInsets.all(12.0), child: InventoryTextField(item)),
        ),
      if (_isOwnerOrAdmin(item) || (item.shareNotes ?? false))
        ContentTab(
          icon: const Icon(Kalinar.note),
          text: AppLocalizations.of(context)!.characterNotes,
          content: Padding(padding: const EdgeInsets.all(12.0), child: NotesTextField(item)),
        ),
      if (_isOwner(item))
        ContentTab(
          icon: const FaIcon(Icons.settings),
          text: AppLocalizations.of(context)!.settings,
          content: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CharacterConfiguration(item, save: _saveField),
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
