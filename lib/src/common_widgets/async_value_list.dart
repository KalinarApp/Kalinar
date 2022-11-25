import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueList<T> extends StatelessWidget {
  final AsyncValue<List<T>> list;
  final Widget Function(T item) builder;
  final Future<void> Function() refreshList;
  final Widget? loading;
  final Widget? error;
  final List<T> Function(List<T> data)? filter;
  final Function(List<T> data)? sort;

  const AsyncValueList(this.list, {required this.builder, required this.refreshList, this.loading, this.error, this.filter, this.sort, super.key});

  @override
  Widget build(BuildContext context) {
    return list.when(
      data: (data) {
        final filtered = null != filter ? filter!(data) : data;
        if (null != sort) sort!(filtered);

        return filtered.isNotEmpty
            ? RefreshIndicator(
                onRefresh: refreshList,
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, index) => builder(filtered[index]),
                ),
              )
            : Center(child: Text(AppLocalizations.of(context)!.listEmpty));
      },
      error: (_, __) => error ?? Center(child: Text(AppLocalizations.of(context)!.listLoadingFailed)),
      loading: () =>
          loading ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const CircularProgressIndicator(), Text(AppLocalizations.of(context)!.listLoading)],
            ),
          ),
    );
  }
}
