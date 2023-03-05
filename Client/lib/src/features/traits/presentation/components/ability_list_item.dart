import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
          subtitle: null != item.description && item.description!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ReadMoreText(
                    item.description!,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    colorClickableText: Theme.of(context).colorScheme.primary,
                    style: TextStyle(color: Theme.of(context).textTheme.bodySmall!.color),
                    trimExpandedText: AppLocalizations.of(context)!.showLess,
                    trimCollapsedText: AppLocalizations.of(context)!.showMore,
                  ),
                )
              : null,
        ),
        const Divider(),
      ],
    );
  }
}
