import 'package:freezed_annotation/freezed_annotation.dart';

enum SuggestionState {
  @JsonValue("Pending")
  pending,
  @JsonValue("Approved")
  approved,
  @JsonValue("Rejected")
  rejected,
}
