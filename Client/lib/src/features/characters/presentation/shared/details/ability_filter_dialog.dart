import 'dart:math';

import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future showAbilityFilterDialog(
    BuildContext context, List<String> availableTags, List<String>? selectedTags, Function(List<String>? selectedTags) update) async {
  availableTags.sortBy((element) => removeDiacritics(element.toLowerCase()));
  return await FilterListDialog.display<String>(
    context,
    listData: availableTags,
    width: kIsWeb ? min(500, MediaQuery.of(context).size.width / 3) : null,
    selectedListData: selectedTags ?? [],
    choiceChipLabel: (tag) => tag,
    hideSearchField: true,
    selectedItemsText: AppLocalizations.of(context)!.selectedTags,
    allButtonText: AppLocalizations.of(context)!.all,
    applyButtonText: AppLocalizations.of(context)!.save,
    resetButtonText: AppLocalizations.of(context)!.delete,
    validateSelectedItem: (list, val) => list?.contains(val) ?? false,
    useRootNavigator: false,
    themeData: FilterListThemeData(
      context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      headerTheme: HeaderThemeData(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        searchFieldBackgroundColor: Colors.transparent,
        searchFieldIconColor: Theme.of(context).iconTheme.color,
        searchFieldInputBorder: const UnderlineInputBorder(),
        closeIconColor: Theme.of(context).iconTheme.color!,
      ),
      controlButtonBarTheme: ControlButtonBarThemeData(
        context,
        backgroundColor: Theme.of(context).canvasColor,
        controlButtonTheme: ControlButtonThemeData(
          textStyle: Theme.of(context).textTheme.bodyLarge,
          primaryButtonBackgroundColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      choiceChipTheme: ChoiceChipThemeData(
        backgroundColor: Theme.of(context).chipTheme.backgroundColor,
        selectedBackgroundColor: Theme.of(context).colorScheme.primary,
      ),
    ),
    onItemSearch: (tag, query) => tag.toLowerCase().contains(removeDiacritics(query.toLowerCase())),
    onApplyButtonClick: (list) {
      update(list);
      Navigator.pop(context);
    },
  );
}
