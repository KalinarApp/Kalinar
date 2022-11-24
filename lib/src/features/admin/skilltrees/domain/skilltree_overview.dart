import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../characters/domain/character_overview.dart';

part 'skilltree_overview.freezed.dart';
part 'skilltree_overview.g.dart';

@freezed
class SkilltreeOverview with _$SkilltreeOverview {
  const factory SkilltreeOverview({
    required String id,
    required String name,
    CharacterOverview? character,
    required int points,
    required int leftPoints,
    required bool isActiveTree,
    required int nodeCount,
    required int unlockedNodeCount,
  }) = _SkilltreeOverview;

  factory SkilltreeOverview.fromJson(Map<String, dynamic> json) => _$SkilltreeOverviewFromJson(json);
}

extension SkilltreeOverviewExtension on List<SkilltreeOverview> {
  List<SkilltreeOverview> unassigned() {
    return where((element) => null == element.character).toList();
  }

  Map<String, List<SkilltreeOverview>> groupByCharacters() {
    final list = where((element) => null != element.character).toList();
    return list.fold({}, (map, element) => map..putIfAbsent(element.character!.id, () => []).add(element));
  }
}
