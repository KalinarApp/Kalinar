import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../../domain/ability.dart';
import '../../domain/suggestion_state.dart';

class AbilityListItem extends StatelessWidget {
  final Ability item;
  final Function(Ability item)? onLongPress;
  final Function(Ability item)? onPress;

  const AbilityListItem(this.item, {this.onLongPress, this.onPress, super.key});

  Widget _getStateIcon(BuildContext context) {
    Widget widget;
    switch (item.state) {
      case SuggestionState.pending:
        widget = const Icon(Icons.circle_outlined, size: 20, color: Colors.green);
        break;
      case SuggestionState.approved:
        widget = Icon(Icons.check_circle_outline, size: 20, color: Theme.of(context).colorScheme.primary);
        break;
      case SuggestionState.rejected:
        widget = Icon(Icons.cancel_outlined, size: 20, color: Theme.of(context).colorScheme.error);
        break;
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    final gravatar = item.creator.email.isNotEmpty ? Gravatar(item.creator.email) : null;

    return Column(
      children: [
        ListTile(
            onTap: null != onPress ? () => onPress!(item) : null,
            onLongPress: null != onLongPress ? () => onLongPress!(item) : null,
            horizontalTitleGap: 0,
            minLeadingWidth: 0,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
            trailing: Container(
              alignment: Alignment.centerRight,
              width: 35,
              child: Column(
                children: [
                  _getStateIcon(context),
                  const SizedBox(height: 5),
                  Timeago(builder: (context, value) => Text(value, maxLines: 1), date: item.createdAt, locale: "en_short"),
                ],
              ),
            ),
            title: Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: (null == item.description || item.description!.isEmpty) && null == gravatar
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
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            if (null != gravatar) CircleAvatar(radius: 15, backgroundImage: CachedNetworkImageProvider(gravatar.imageUrl())),
                            if (null != gravatar) const SizedBox(width: 12),
                            // Container(
                            //   width: 45,
                            //   height: 20,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(20),
                            //     color: Theme.of(context).colorScheme.background,
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(4.0),
                            //     child: Row(
                            //       children: [
                            //         const Icon(Icons.chat_bubble, size: 15),
                            //         const SizedBox(width: 3),
                            //         Text("12", style: Theme.of(context).textTheme.bodySmall),
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                  )),
        const Divider(),
      ],
    );
  }
}
