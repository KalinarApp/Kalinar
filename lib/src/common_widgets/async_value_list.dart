import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'debounced_text_field.dart';

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
  String? queryString;

  @override
  Widget build(BuildContext context) {
    return widget.list.when(
      data: (data) {
        final filtered = null != widget.filter ? widget.filter!(data) : data;
        if (null != widget.sort) widget.sort!(filtered);
        final queried = null != widget.queryFn ? widget.queryFn!(filtered, queryString) : filtered;

        return queried.isEmpty && null == queryString
            ? Center(child: Text(AppLocalizations.of(context)!.listEmpty))
            : RefreshIndicator(
                onRefresh: widget.refreshList,
                child: CustomScrollView(
                  slivers: [
                    if (widget.isSearchable)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, left: 4, right: 4),
                          child: DebouncedTextField(
                            icon: const Icon(Icons.search),
                            title: AppLocalizations.of(context)!.search,
                            duration: const Duration(milliseconds: 100),
                            onChanged: (currentText) => setState(() => queryString = currentText),
                          ),
                        ),
                      ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => widget.builder(queried[index]),
                        childCount: queried.length,
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
