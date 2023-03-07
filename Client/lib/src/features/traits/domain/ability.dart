import 'package:freezed_annotation/freezed_annotation.dart';

import '../../group_management/domain/user.dart';
import 'suggestable.dart';
import 'suggestion_state.dart';

part 'ability.freezed.dart';
part 'ability.g.dart';

@freezed
class Ability with _$Ability implements Suggestable {
  const factory Ability({
    required String id,
    required String name,
    String? description,
    required bool isPassive,
    required User creator,
    required SuggestionState state,
    String? rejectionReason,
    required DateTime createdAt,
    DateTime? lastUpdatedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  }) = _Ability;

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
}
