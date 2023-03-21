import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:readmore/readmore.dart';

import '../../../../traits/domain/ability.dart';

class AbilityListTile extends ListTile {
  AbilityListTile(Ability item, BuildContext context, {Function()? onLongPress, bool showTags = false, super.key})
      : super(
            minLeadingWidth: 0,
            onLongPress: onLongPress,
            contentPadding: EdgeInsets.zero,
            title: Text(item.name),
            subtitle: (null == item.description || item.description!.isEmpty)
                ? null
                : Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (null != item.description && item.description!.isNotEmpty)
                          ReadMoreText(
                            item.description!,
                            trimLines: 2,
                            trimMode: TrimMode.Line,
                            colorClickableText: Theme.of(context).colorScheme.primary,
                            style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
                            trimExpandedText: AppLocalizations.of(context)!.showLess,
                            trimCollapsedText: AppLocalizations.of(context)!.showMore,
                          ),
                        if (showTags) const SizedBox(height: 5),
                        if (showTags)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (final tag in item.tags.take(3))
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Container(
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).colorScheme.background),
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
                  ));
}
