import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common_widgets/debounced_text_field.dart';
import '../../../../common_widgets/loading_indicator.dart';

class SearchableList<T> extends StatelessWidget {
  final List<T>? items;
  final Widget? Function(BuildContext context, int index) itemBuilder;

  final bool isSearchEnabled;
  final Future Function() onRefresh;
  final Function(String? query)? onSearchChanged;

  const SearchableList(this.items,
      {required this.onRefresh, required this.itemBuilder, this.onSearchChanged, this.isSearchEnabled = true, super.key});

  @override
  Widget build(BuildContext context) {
    return null == items
        ? LoadingIndicator(AppLocalizations.of(context)!.listLoading)
        : RefreshIndicator(
            onRefresh: onRefresh,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Flexible(
                          child: DebouncedTextField(
                            icon: const Icon(Icons.search),
                            title: AppLocalizations.of(context)!.search,
                            isEnabled: isSearchEnabled,
                            canClear: true,
                            onChanged: onSearchChanged ?? (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(delegate: SliverChildBuilderDelegate(itemBuilder, childCount: items!.length))
              ],
            ),
          );
  }
}
