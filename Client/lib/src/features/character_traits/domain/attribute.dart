import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kalinar/src/features/character_traits/domain/suggestable.dart';

import 'suggestion_state.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

@freezed
class Attribute extends Suggestable with _$Attribute {
  factory Attribute(
    String id,
    String groupId,
    String creatorId,
    String name,
    String? iconData,
    String? description,
    String? category,
    double stepSize,
    double minValue,
    double maxValue,
    SuggestionState state,
    String? rejectionReason,
    DateTime createdAt,
    DateTime? modifiedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  ) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}
