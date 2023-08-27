import 'suggestion_state.dart';

abstract class Suggestable {
  String get id;
  String get name;
  String? get description;

  SuggestionState get state;
  String? get rejectionReason;
  DateTime get createdAt;
  DateTime? get modifiedAt;
  DateTime? get approvedAt;
  DateTime? get rejectedAt;
}
