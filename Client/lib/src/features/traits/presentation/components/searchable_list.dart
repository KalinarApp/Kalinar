import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalinar/src/features/traits/application/state/filter_state.dart';
import 'package:kalinar/src/features/traits/domain/suggestion_state.dart';
import 'package:multiselect/multiselect.dart';

import '../../../../common_widgets/custom_image_button.dart';
import '../../../../common_widgets/debounced_text_field.dart';
import '../../../../common_widgets/loading_indicator.dart';

class SuggestionStateSelection {
  final SuggestionState state;
  final BuildContext context;

  SuggestionStateSelection(this.state, this.context);

  @override
  String toString() => state.translate(context);

  @override
  bool operator ==(Object other) => (other as SuggestionStateSelection?)?.state == state;

  @override
  int get hashCode => state.hashCode;
}

class SearchableList<T> extends StatelessWidget {
  final List<T>? items;
  final Widget? Function(BuildContext context, int index) itemBuilder;

  final bool isSearchEnabled;
  final Future Function() onRefresh;
  final Function(String? query)? onSearchChanged;

  final FilterState filter;
  final Function(FilterState filter)? onFilterChanged;

  const SearchableList(this.items,
      {required this.onRefresh,
      this.onFilterChanged,
      this.filter = const FilterState(),
      required this.itemBuilder,
      this.onSearchChanged,
      this.isSearchEnabled = true,
      super.key});

  Future _showDialog(BuildContext context) async {
    List<SuggestionStateSelection> selectedValues = filter.states.map((e) => SuggestionStateSelection(e, context)).toList();
    final options = SuggestionState.values.map((e) => SuggestionStateSelection(e, context)).toList();

    if (!context.mounted) return;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.filter),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropDownMultiSelect(
              options: options,
              selectedValues: selectedValues,
              onChanged: (_) {},
              whenEmpty: AppLocalizations.of(context)!.filterState,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(child: Text(AppLocalizations.of(context)!.ok), onPressed: () => Navigator.pop(context, true)),
        ],
      ),
    );

    if (null != onFilterChanged) onFilterChanged!(FilterState(states: selectedValues.map((e) => e.state).toList()));
    onRefresh();
  }

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
                        CustomImageButton(icon: const FaIcon(FontAwesomeIcons.filter), onPressed: () => _showDialog(context))
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
