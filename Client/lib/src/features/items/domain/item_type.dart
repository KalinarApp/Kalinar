// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../kalinar_icons.dart';

enum ItemType {
  @JsonValue("Item")
  item,
  @JsonValue("Weapon")
  weapon,
}

extension StoryEntryTypeExtensions on ItemType {
  String getTitle(BuildContext context) {
    switch (this) {
      case ItemType.item:
        return AppLocalizations.of(context)!.item;
      case ItemType.weapon:
        return AppLocalizations.of(context)!.weapon;
    }
  }

  Widget getIcon() {
    switch (this) {
      case ItemType.item:
        return const Icon(FontAwesomeIcons.box);
      case ItemType.weapon:
        return const Icon(Kalinar.firearm);
    }
  }
}
