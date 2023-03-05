import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../traits/domain/ability.dart';
import '../../../traits/domain/attribute_value.dart';

part 'skill.freezed.dart';
part 'skill.g.dart';

@freezed
class Skill with _$Skill {
  const factory Skill(
    String id, {
    Ability? ability,
    String? iconUrl,
    required String name,
    String? description,
    @Default([]) List<AttributeValue> attributes,
  }) = _Skill;

  factory Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);
}
