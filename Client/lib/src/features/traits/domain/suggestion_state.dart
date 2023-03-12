import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum SuggestionState {
  @JsonValue("Pending")
  pending,
  @JsonValue("Approved")
  approved,
  @JsonValue("Rejected")
  rejected,
}

extension SuggestionStateExtension on SuggestionState {
  String translate(BuildContext context) {
    switch (this) {
      case SuggestionState.pending:
        return AppLocalizations.of(context)!.pending;
      case SuggestionState.approved:
        return AppLocalizations.of(context)!.approved;
      case SuggestionState.rejected:
        return AppLocalizations.of(context)!.rejected;
    }
  }
}
