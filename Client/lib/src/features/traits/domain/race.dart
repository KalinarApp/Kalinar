import 'package:freezed_annotation/freezed_annotation.dart';

import '../../user_management/domain/user.dart';
import 'attribute_value.dart';
import 'suggestable.dart';
import 'suggestion_state.dart';

part 'race.freezed.dart';
part 'race.g.dart';

@freezed
class Race with _$Race implements Suggestable {
  const factory Race({
    required String id,
    required String name,
    String? description,
    @Default([]) List<AttributeValue> attributes,
    required User? creator,
    required SuggestionState state,
    String? rejectionReason,
    required DateTime createdAt,
    DateTime? lastUpdatedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  }) = _Race;

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);
}
