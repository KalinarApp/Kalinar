import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../constants/app_sizes.dart';
import '../../../utils/build_context_extensions.dart';

enum SuggestionState {
  @JsonValue("Pending")
  pending,
  @JsonValue("Approved")
  approved,
  @JsonValue("Rejected")
  rejected,
}

extension SuggestableStateExtensions on SuggestionState {
  Widget getIcon(BuildContext context) {
    switch (this) {
      case SuggestionState.pending:
        return const Icon(Icons.circle_outlined, size: Sizes.p20, color: Colors.green);
      case SuggestionState.approved:
        return Icon(Icons.check_circle_outline, size: Sizes.p20, color: context.colorScheme.primary);
      case SuggestionState.rejected:
        return Icon(Icons.cancel_outlined, size: Sizes.p20, color: context.colorScheme.error);
    }
  }

  String getLocalization(BuildContext context) {
    switch (this) {
      case SuggestionState.pending:
        return context.localizations.pending;
      case SuggestionState.approved:
        return context.localizations.approved;
      case SuggestionState.rejected:
        return context.localizations.rejected;
    }
  }
}
