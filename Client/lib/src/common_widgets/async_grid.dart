import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/app_sizes.dart';
import 'no_animation_custom_scroll_view.dart';
import 'spinner.dart';

class AsyncGrid<T> extends StatelessWidget {
  final AsyncValue<List<T>> list;
  final SliverGridDelegate gridDelegate;
  final Widget Function(T item) builder;
  final Future<void> Function() refreshList;
  final List<T> Function(List<T> data)? filter;
  final List<T> Function(List<T> data)? sort;

  const AsyncGrid(
    this.list, {
    required this.builder,
    required this.refreshList,
    required this.gridDelegate,
    this.filter,
    this.sort,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return list.maybeWhen(
        data: (data) {
          List<T> filtered = null != filter ? filter!(data) : data;
          if (null != sort) filtered = sort!(filtered);

          return filtered.isNotEmpty
              ? RefreshIndicator(
                  onRefresh: refreshList,
                  child: NoAnimationCustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(Sizes.p12),
                        sliver: SliverGrid.builder(
                          itemBuilder: (context, index) => builder(filtered[index]),
                          itemCount: filtered.length,
                          gridDelegate: gridDelegate,
                        ),
                      ),
                    ],
                  ),
                )
              : Center(child: Text(AppLocalizations.of(context)!.listEmpty));
        },
        orElse: () => const Center(child: Spinner()));
  }
}
