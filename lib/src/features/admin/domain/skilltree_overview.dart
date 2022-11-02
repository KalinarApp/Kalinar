import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hero/src/features/character_management/domain/character.dart';

import 'node.dart';

part 'skilltree_overview.freezed.dart';
part 'skilltree_overview.g.dart';

@freezed
class SkilltreeOverview with _$SkilltreeOverview {
  const factory SkilltreeOverview({
    required String id,
    required String name,
    Character? character,
    required int points,
    required bool isActiveTree,
    required int nodeCount,
  }) = _SkilltreeOverview;

  factory SkilltreeOverview.fromJson(Map<String, dynamic> json) => _$SkilltreeOverviewFromJson(json);
}
