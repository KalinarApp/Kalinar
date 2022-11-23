import 'package:freezed_annotation/freezed_annotation.dart';

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
    required String raceId,
    required Race race,
    @Default([]) List<SkilltreeOverview> skilltrees,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}
