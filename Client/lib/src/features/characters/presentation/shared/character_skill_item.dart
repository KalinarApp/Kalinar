import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kalinar/src/features/traits/domain/ability.dart';
import 'package:readmore/readmore.dart';

import '../../../../common_widgets/node_tile.dart';
import '../../domain/character_skill.dart';

class CharacterSkillItem extends StatelessWidget {
  final CharacterSkill item;
  final String? ownerId;
  final Function(String tag) onTagSelected;
  final Function(Ability ability)? onEditAbility;
  final Function(CharacterSkill skill, bool isFavorite)? markAsFavorite;

  const CharacterSkillItem(this.item, {required this.onTagSelected, this.markAsFavorite, this.ownerId, this.onEditAbility, super.key});

  @override
  Widget build(BuildContext context) {
    final ability = item.ability!;
    final isOwner = FirebaseAuth.instance.currentUser?.uid == ownerId;

    return LayoutBuilder(
      builder: (ctx, constraints) => ListTile(
        leading: constraints.maxWidth < 300 || item.iconUrl == null ? null : NodeTile(Image(image: CachedNetworkImageProvider(item.iconUrl!))),
        // trailing: PopupMenuButton<DialogAction>(itemBuilder: (context) {
        //   return [
        //     PopupMenuItem(
        //       value: DialogAction.edit,
        //       onTap: () => onEditAbility?.call(ability),
        //       child: ListTile(leading: DialogAction.edit.getIcon(), title: Text(DialogAction.edit.getTitle(context))),
        //     ),
        //   ];
        // }),
        title: SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(text: ability.name, style: Theme.of(context).textTheme.titleMedium),
              const WidgetSpan(child: SizedBox(width: 5)),
              if (item.isFavorite)
                WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: GestureDetector(
                    onTap: markAsFavorite != null ? () => markAsFavorite!.call(item, false) : null,
                    child: const Icon(Icons.star, color: Colors.amber, size: 18),
                  ),
                ),
              if (!item.isFavorite && isOwner)
                WidgetSpan(
                  alignment: PlaceholderAlignment.bottom,
                  child: GestureDetector(
                    onTap: markAsFavorite != null ? () => markAsFavorite!.call(item, true) : null,
                    child: const Icon(Icons.star_border, size: 18),
                  ),
                ),
            ],
          ),
        ),
        subtitle: (null == ability.description || ability.description!.isEmpty)
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (null != ability.description && ability.description!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SelectionArea(
                          child: ReadMoreText(
                            ability.description!,
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            colorClickableText: Theme.of(context).colorScheme.primary,
                            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
                            trimExpandedText: AppLocalizations.of(context)!.showLess,
                            trimCollapsedText: AppLocalizations.of(context)!.showMore,
                          ),
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final tag in ability.tags.take(3))
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.background),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                                child: Text(tag, style: Theme.of(context).textTheme.labelMedium),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
