// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FilterState _$$_FilterStateFromJson(Map<String, dynamic> json) =>
    _$_FilterState(
      states: (json['states'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$SuggestionStateEnumMap, e))
              .toList() ??
          SuggestionState.values,
    );

Map<String, dynamic> _$$_FilterStateToJson(_$_FilterState instance) =>
    <String, dynamic>{
      'states':
          instance.states.map((e) => _$SuggestionStateEnumMap[e]!).toList(),
    };

const _$SuggestionStateEnumMap = {
  SuggestionState.pending: 'Pending',
  SuggestionState.approved: 'Approved',
  SuggestionState.rejected: 'Rejected',
};
