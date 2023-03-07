import 'dart:core';

import '../../group_management/domain/user.dart';
import 'suggestion_state.dart';

abstract class Suggestable {
  String get id;
  String get name;
  String? get description;

  User get creator;
  SuggestionState get state;
  String? get rejectionReason;
  DateTime get createdAt;
  DateTime? get lastUpdatedAt;
  DateTime? get approvedAt;
  DateTime? get rejectedAt;
}
