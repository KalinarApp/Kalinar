import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/skilltree_overview.dart';

part 'skilltree_overview_state.freezed.dart';
part 'skilltree_overview_state.g.dart';

@freezed
class SkilltreeOverviewState with _$SkilltreeOverviewState {
  const factory SkilltreeOverviewState({
    @Default([]) List<SkilltreeOverview> unassigned,
    @Default({}) Map<String, List<SkilltreeOverview>> characters,
    @Default(false) bool isSaving,
  }) = _SkilltreeOverviewState;

  factory SkilltreeOverviewState.fromJson(Map<String, dynamic> json) => _$SkilltreeOverviewStateFromJson(json);
}
