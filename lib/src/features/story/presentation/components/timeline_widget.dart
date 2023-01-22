import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../admin/storyline/domain/story_entry_overview.dart';

class TimelineWidget extends StatefulWidget {
  final List<StoryEntryOverview> entries;

  const TimelineWidget(this.entries, {super.key});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  Widget _buildItem(StoryEntryOverview item, bool isEven) {
    return Padding(
      padding: EdgeInsets.only(right: isEven ? 16 : 10, top: 16, bottom: 16, left: isEven ? 10 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: null == item.description ? MainAxisAlignment.center : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(item.title, style: Theme.of(context).textTheme.titleLarge, maxLines: 2),
          const SizedBox(height: 5),
          if (null != item.description) Text(item.description!, style: Theme.of(context).textTheme.caption),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<StoryEntryOverview> items = [...widget.entries];
    items.sort((a, b) => a.order.compareTo(b.order));

    return SliverPadding(
      padding: const EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 10),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.timeline, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            for (int i = 0; i < items.length; i++)
              Column(
                children: [
                  if (i.isOdd)
                    const TimelineDivider(
                      begin: .05,
                      end: .95,
                      thickness: 4,
                    ),
                  TimelineTile(
                    indicatorStyle: IndicatorStyle(
                      width: 30,
                      height: 30,
                      indicator: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Center(child: AutoSizeText(items[i].date!, maxLines: 2, textAlign: TextAlign.center, minFontSize: 8)),
                        ),
                      ),
                    ),
                    alignment: TimelineAlign.manual,
                    lineXY: i.isEven ? .05 : .95,
                    startChild: i.isOdd ? _buildItem(items[i], i.isEven) : null,
                    endChild: i.isEven ? _buildItem(items[i], i.isEven) : null,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
