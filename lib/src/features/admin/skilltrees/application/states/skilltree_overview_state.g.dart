// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skilltree_overview_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SkilltreeOverviewState _$$_SkilltreeOverviewStateFromJson(Map<String, dynamic> json) => _$_SkilltreeOverviewState(
      unassigned: (json['unassigned'] as List<dynamic>?)?.map((e) => SkilltreeOverview.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
      characters: (json['characters'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as List<dynamic>).map((e) => SkilltreeOverview.fromJson(e as Map<String, dynamic>)).toList()),
          ) ??
          const {},
      isSaving: json['isSaving'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SkilltreeOverviewStateToJson(_$_SkilltreeOverviewState instance) => <String, dynamic>{
      'unassigned': instance.unassigned,
      'characters': instance.characters,
      'isSaving': instance.isSaving,
    };
