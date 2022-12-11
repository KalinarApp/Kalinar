import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/common_widgets/searchable_list.dart';

class AsyncValueList<T> extends StatefulWidget {
  final AsyncValue<List<T>> list;
  final Widget Function(T item) builder;
  final Future<void> Function() refreshList;
  final Widget? loading;
  final Widget? error;
  final bool isSearchable;
  final List<T> Function(List<T> items, String? query)? queryFn;
  final List<T> Function(List<T> data)? filter;
  final Function(List<T> data)? sort;

  const AsyncValueList(
    this.list, {
    required this.builder,
    required this.refreshList,
    this.loading,
    this.error,
    this.isSearchable = false,
    this.queryFn,
    this.filter,
    this.sort,
    super.key,
  });

  @override
  State<AsyncValueList<T>> createState() => _AsyncValueListState<T>();
}

class _AsyncValueListState<T> extends State<AsyncValueList<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.list.when(
      data: (data) {
        final filtered = null != widget.filter ? widget.filter!(data) : data;
        if (null != widget.sort) widget.sort!(filtered);

        return filtered.isEmpty
            ? Center(child: Text(AppLocalizations.of(context)!.listEmpty))
            : widget.isSearchable
                ? SearchableList(filtered, refreshList: widget.refreshList, itemBuilder: widget.builder, search: widget.queryFn!)
                : RefreshIndicator(
                    onRefresh: widget.refreshList,
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => widget.builder(filtered[index]),
                            childCount: filtered.length,
                          ),
                        ),
                      ],
                    ),
                  );
      },
      error: (_, __) => widget.error ?? Center(child: Text(AppLocalizations.of(context)!.listLoadingFailed)),
      loading: () =>
          widget.loading ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const CircularProgressIndicator(), Text(AppLocalizations.of(context)!.listLoading)],
            ),
          ),
    );
  }
}
