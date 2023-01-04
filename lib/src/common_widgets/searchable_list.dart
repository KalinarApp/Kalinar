import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'debounced_text_field.dart';

class SearchableList<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final Future<void> Function() refreshList;
  final List<T> Function(List<T> items, String? query) search;

  const SearchableList(this.items, {required this.refreshList, required this.itemBuilder, required this.search, super.key});

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  List<T> items = [];

  void _search(String? query) {
    final result = widget.search(widget.items, query);
    setState(() => items = result);
  }

  @override
  void didChangeDependencies() {
    setState(() {
      items = widget.items;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.refreshList,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 4, right: 4),
              child: DebouncedTextField(
                icon: const Icon(Icons.search),
                title: AppLocalizations.of(context)!.search,
                duration: const Duration(milliseconds: 100),
                onChanged: _search,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => widget.itemBuilder(items[index]),
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
