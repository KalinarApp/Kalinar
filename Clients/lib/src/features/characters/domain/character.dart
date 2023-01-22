import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:kalinar/src/features/admin/management/domain/attribute_value.dart';

import '../../admin/management/domain/ability.dart';
import '../../admin/management/domain/race.dart';
import '../../admin/skilltrees/domain/skilltree_overview.dart';

part 'character.freezed.dart';
part 'character.g.dart';

@freezed
class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    int? age,
    String? iconUrl,
    String? description,
    String? profession,
    String? religion,
    String? relationship,
    String? notes,
    String? inventory,
    String? userId,
    @Default(false) bool isPublic,
    bool? shareSkilltree,
    bool? shareNotes,
    bool? shareInventory,
    bool? shareAbilities,
    bool? shareAttributes,
    @Default([]) List<AttributeValue> attributes,
    required String raceId,
    required Race race,
    @Default([]) List<SkilltreeOverview> skilltrees,
    @Default([]) List<Ability> unlockedAbilities,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}
