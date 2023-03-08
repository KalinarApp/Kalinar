import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/form_fields/typeahead_text_field.dart';
import '../../application/controller/attributes_controller.dart';

class CategorySelection extends ConsumerStatefulWidget {
  final String? category;
  final bool enabled;

  const CategorySelection(this.category, {this.enabled = true, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends ConsumerState<CategorySelection> {
  final controller = TextEditingController();

  @override
  void didChangeDependencies() {
    if (null != widget.category) {
      controller.text = widget.category!;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadTextField(
      name: "category",
      decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeCategory),
      itemBuilder: (context, itemData) => ListTile(title: Text(itemData)),
      suggestionsCallback: (pattern) async => await ref.read(attributesControllerProvider).getCategories(pattern),
      getImmediateSuggestions: false,
      hideOnEmpty: true,
      hideOnError: true,
      hideOnLoading: true,
      hideSuggestionsOnKeyboardHide: true,
      enabled: widget.enabled,
      keepSuggestionsOnLoading: true,
    );
  }
}
