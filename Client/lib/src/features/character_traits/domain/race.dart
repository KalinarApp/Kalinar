import 'package:freezed_annotation/freezed_annotation.dart';

import 'suggestable.dart';
import 'suggestion_state.dart';

part 'race.freezed.dart';
part 'race.g.dart';

@freezed
class Race extends Suggestable with _$Race {
  factory Race(
    String id,
    String groupId,
    String creatorId,
    String name,
    String? description,
    SuggestionState state,
    String? rejectionReason,
    DateTime createdAt,
    DateTime? modifiedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  ) = _Race;

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);
}
