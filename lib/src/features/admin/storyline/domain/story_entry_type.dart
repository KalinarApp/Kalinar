// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum StoryEntryType {
  StoryImage,
  StoryBook,
}

extension StoryEntryTypeExtensions on StoryEntryType {
  FaIcon getIcon() {
    switch (this) {
      case StoryEntryType.StoryImage:
        return const FaIcon(FontAwesomeIcons.image);
      case StoryEntryType.StoryBook:
        return const FaIcon(FontAwesomeIcons.bookAtlas);
    }
  }

  String getTitle(BuildContext context) {
    switch (this) {
      case StoryEntryType.StoryImage:
        return AppLocalizations.of(context)!.storyImage;
      case StoryEntryType.StoryBook:
        return AppLocalizations.of(context)!.storyBook;
    }
  }
}
