import 'package:freezed_annotation/freezed_annotation.dart';

import '../../admin/management/domain/race.dart';

part 'character_overview.freezed.dart';
part 'character_overview.g.dart';

@freezed
class CharacterOverview with _$CharacterOverview {
  const factory CharacterOverview({
    required String id,
    required String name,
    String? iconUrl,
  }) = _CharacterOverview;

  factory CharacterOverview.fromJson(Map<String, dynamic> json) => _$CharacterOverviewFromJson(json);
}
