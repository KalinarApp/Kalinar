import 'package:freezed_annotation/freezed_annotation.dart';

import '../../traits/domain/ability.dart';
import '../../traits/domain/attribute_value.dart';

part 'character_skill.freezed.dart';
part 'character_skill.g.dart';

@freezed
class CharacterSkill with _$CharacterSkill {
  const factory CharacterSkill(
    String id, {
    Ability? ability,
    String? iconUrl,
    required String name,
    String? description,
    @Default(false) bool isFavorite,
    @Default([]) List<AttributeValue> attributes,
  }) = _CharacterSkill;

  factory CharacterSkill.fromJson(Map<String, dynamic> json) => _$CharacterSkillFromJson(json);
}
