import 'package:freezed_annotation/freezed_annotation.dart';

import 'suggestable.dart';
import 'suggestion_state.dart';

part 'ability.freezed.dart';
part 'ability.g.dart';

@freezed
class Ability extends Suggestable with _$Ability {
  factory Ability(
    String id,
    String groupId,
    String creatorId,
    String name,
    String? description,
    bool isPassive,
    SuggestionState state,
    String? rejectionReason,
    DateTime createdAt,
    DateTime? modifiedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  ) = _Ability;

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);
}
