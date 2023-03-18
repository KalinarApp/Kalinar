import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/suggestion_state.dart';

part 'filter_state.freezed.dart';
part 'filter_state.g.dart';

@Freezed()
class FilterState with _$FilterState {
  const factory FilterState({
    @Default(SuggestionState.values) List<SuggestionState> states,
  }) = _FilterState;

  factory FilterState.fromJson(Map<String, dynamic> json) => _$FilterStateFromJson(json);
}
