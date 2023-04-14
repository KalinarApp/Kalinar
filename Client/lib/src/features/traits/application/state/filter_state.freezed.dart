// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FilterState _$FilterStateFromJson(Map<String, dynamic> json) {
  return _FilterState.fromJson(json);
}

/// @nodoc
mixin _$FilterState {
  List<SuggestionState> get states => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterStateCopyWith<FilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterStateCopyWith<$Res> {
  factory $FilterStateCopyWith(
          FilterState value, $Res Function(FilterState) then) =
      _$FilterStateCopyWithImpl<$Res, FilterState>;
  @useResult
  $Res call({List<SuggestionState> states});
}

/// @nodoc
class _$FilterStateCopyWithImpl<$Res, $Val extends FilterState>
    implements $FilterStateCopyWith<$Res> {
  _$FilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? states = null,
  }) {
    return _then(_value.copyWith(
      states: null == states
          ? _value.states
          : states // ignore: cast_nullable_to_non_nullable
              as List<SuggestionState>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FilterStateCopyWith<$Res>
    implements $FilterStateCopyWith<$Res> {
  factory _$$_FilterStateCopyWith(
          _$_FilterState value, $Res Function(_$_FilterState) then) =
      __$$_FilterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SuggestionState> states});
}

/// @nodoc
class __$$_FilterStateCopyWithImpl<$Res>
    extends _$FilterStateCopyWithImpl<$Res, _$_FilterState>
    implements _$$_FilterStateCopyWith<$Res> {
  __$$_FilterStateCopyWithImpl(
      _$_FilterState _value, $Res Function(_$_FilterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? states = null,
  }) {
    return _then(_$_FilterState(
      states: null == states
          ? _value._states
          : states // ignore: cast_nullable_to_non_nullable
              as List<SuggestionState>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FilterState implements _FilterState {
  const _$_FilterState(
      {final List<SuggestionState> states = SuggestionState.values})
      : _states = states;

  factory _$_FilterState.fromJson(Map<String, dynamic> json) =>
      _$$_FilterStateFromJson(json);

  final List<SuggestionState> _states;
  @override
  @JsonKey()
  List<SuggestionState> get states {
    if (_states is EqualUnmodifiableListView) return _states;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_states);
  }

  @override
  String toString() {
    return 'FilterState(states: $states)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FilterState &&
            const DeepCollectionEquality().equals(other._states, _states));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_states));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FilterStateCopyWith<_$_FilterState> get copyWith =>
      __$$_FilterStateCopyWithImpl<_$_FilterState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilterStateToJson(
      this,
    );
  }
}

abstract class _FilterState implements FilterState {
  const factory _FilterState({final List<SuggestionState> states}) =
      _$_FilterState;

  factory _FilterState.fromJson(Map<String, dynamic> json) =
      _$_FilterState.fromJson;

  @override
  List<SuggestionState> get states;
  @override
  @JsonKey(ignore: true)
  _$$_FilterStateCopyWith<_$_FilterState> get copyWith =>
      throw _privateConstructorUsedError;
}
