// ignore_for_file: use_build_context_synchronously

import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../common_widgets/action_menu.dart';
import '../../../../traits/application/controller/abilities_controller.dart';
import '../../../../traits/domain/ability.dart';
import '../../../../traits/presentation/edit_ability_screen.dart';
import '../../../domain/character.dart';
import '../../shared/details/ability_list_tile.dart';

class CharacterAbilities extends HookConsumerWidget {
  final Character character;
  final String? query;
  final List<String>? tags;

  const CharacterAbilities(this.character, {this.query, this.tags, super.key});

  Future _onEdit(BuildContext context, WidgetRef ref, Ability item) async {
    ref.read(abilitiesControllerProvider).getById(item.id);
    context.pushNamed(EditAbilityScreen.name, queryParameters: {"id": item.id});
  }

  ListTile _getListItem(BuildContext context, WidgetRef ref, Ability item, {bool showTags = false}) {
    return AbilityListTile(
      item,
      context,
      showTags: showTags,
      contextBuilder: () => _buildContextMenuForWeb(context, ref, item),
      onLongPress: () async {
        final action = await showActionsModal(context, actions: [DialogAction.edit, DialogAction.cancel]);
        if (null == action || !context.mounted) return;

        switch (action) {
          case DialogAction.edit:
          case DialogAction.delete:
          default:
            break;
        }
      },
    );
  }

  Widget? _buildContextMenuForWeb(BuildContext context, WidgetRef ref, Ability item) {
    return !kIsWeb
        ? null
        : PopupMenuButton<DialogAction>(itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: DialogAction.edit,
                onTap: () => _onEdit(context, ref, item),
                child: ListTile(leading: DialogAction.edit.getIcon(), title: Text(DialogAction.edit.getTitle(context))),
              ),
            ];
          });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    List<Ability> abilities = character.unlockedAbilities..sortBy((element) => removeDiacritics(element.name.toLowerCase()));

    if (tags != null && tags!.isNotEmpty) {
      abilities = abilities.where((item) => tags!.any((tag) => item.tags.contains(tag))).toList();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 12.0),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowIndicator();
          return false;
        },
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) => _getListItem(context, ref, abilities[index], showTags: true),
                      childCount: abilities.length))
            ],
          ),
        ),
      ),
    );
  }
}
