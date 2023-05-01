// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../kalinar_icons.dart';

enum ItemType {
  Item,
  Weapon;

  String toJson() => name;
  static ItemType fromJson(String json) => values.byName(json);
}

extension StoryEntryTypeExtensions on ItemType {
  String getTitle(BuildContext context) {
    switch (this) {
      case ItemType.Item:
        return AppLocalizations.of(context)!.item;
      case ItemType.Weapon:
        return AppLocalizations.of(context)!.weapon;
    }
  }

  Widget getIcon() {
    switch (this) {
      case ItemType.Item:
        return const Icon(FontAwesomeIcons.box);
      case ItemType.Weapon:
        return const Icon(Kalinar.firearm);
    }
  }
}
