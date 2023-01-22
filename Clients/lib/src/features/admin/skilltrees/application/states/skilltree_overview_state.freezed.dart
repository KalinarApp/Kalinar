// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'skilltree_overview_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SkilltreeOverviewState _$SkilltreeOverviewStateFromJson(
    Map<String, dynamic> json) {
  return _SkilltreeOverviewState.fromJson(json);
}

/// @nodoc
mixin _$SkilltreeOverviewState {
  List<SkilltreeOverview> get unassigned => throw _privateConstructorUsedError;
  Map<String, List<SkilltreeOverview>> get characters =>
      throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkilltreeOverviewStateCopyWith<SkilltreeOverviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkilltreeOverviewStateCopyWith<$Res> {
  factory $SkilltreeOverviewStateCopyWith(SkilltreeOverviewState value,
          $Res Function(SkilltreeOverviewState) then) =
      _$SkilltreeOverviewStateCopyWithImpl<$Res, SkilltreeOverviewState>;
  @useResult
  $Res call(
      {List<SkilltreeOverview> unassigned,
      Map<String, List<SkilltreeOverview>> characters,
      bool isSaving});
}

/// @nodoc
class _$SkilltreeOverviewStateCopyWithImpl<$Res,
        $Val extends SkilltreeOverviewState>
    implements $SkilltreeOverviewStateCopyWith<$Res> {
  _$SkilltreeOverviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unassigned = null,
    Object? characters = null,
    Object? isSaving = null,
  }) {
    return _then(_value.copyWith(
      unassigned: null == unassigned
          ? _value.unassigned
          : unassigned // ignore: cast_nullable_to_non_nullable
              as List<SkilltreeOverview>,
      characters: null == characters
          ? _value.characters
          : characters // ignore: cast_nullable_to_non_nullable
              as Map<String, List<SkilltreeOverview>>,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SkilltreeOverviewStateCopyWith<$Res>
    implements $SkilltreeOverviewStateCopyWith<$Res> {
  factory _$$_SkilltreeOverviewStateCopyWith(_$_SkilltreeOverviewState value,
          $Res Function(_$_SkilltreeOverviewState) then) =
      __$$_SkilltreeOverviewStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SkilltreeOverview> unassigned,
      Map<String, List<SkilltreeOverview>> characters,
      bool isSaving});
}

/// @nodoc
class __$$_SkilltreeOverviewStateCopyWithImpl<$Res>
    extends _$SkilltreeOverviewStateCopyWithImpl<$Res,
        _$_SkilltreeOverviewState>
    implements _$$_SkilltreeOverviewStateCopyWith<$Res> {
  __$$_SkilltreeOverviewStateCopyWithImpl(_$_SkilltreeOverviewState _value,
      $Res Function(_$_SkilltreeOverviewState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unassigned = null,
    Object? characters = null,
    Object? isSaving = null,
  }) {
    return _then(_$_SkilltreeOverviewState(
      unassigned: null == unassigned
          ? _value._unassigned
          : unassigned // ignore: cast_nullable_to_non_nullable
              as List<SkilltreeOverview>,
      characters: null == characters
          ? _value._characters
          : characters // ignore: cast_nullable_to_non_nullable
              as Map<String, List<SkilltreeOverview>>,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SkilltreeOverviewState implements _SkilltreeOverviewState {
  const _$_SkilltreeOverviewState(
      {final List<SkilltreeOverview> unassigned = const [],
      final Map<String, List<SkilltreeOverview>> characters = const {},
      this.isSaving = false})
      : _unassigned = unassigned,
        _characters = characters;

  factory _$_SkilltreeOverviewState.fromJson(Map<String, dynamic> json) =>
      _$$_SkilltreeOverviewStateFromJson(json);

  final List<SkilltreeOverview> _unassigned;
  @override
  @JsonKey()
  List<SkilltreeOverview> get unassigned {
    if (_unassigned is EqualUnmodifiableListView) return _unassigned;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unassigned);
  }

  final Map<String, List<SkilltreeOverview>> _characters;
  @override
  @JsonKey()
  Map<String, List<SkilltreeOverview>> get characters {
    if (_characters is EqualUnmodifiableMapView) return _characters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_characters);
  }

  @override
  @JsonKey()
  final bool isSaving;

  @override
  String toString() {
    return 'SkilltreeOverviewState(unassigned: $unassigned, characters: $characters, isSaving: $isSaving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SkilltreeOverviewState &&
            const DeepCollectionEquality()
                .equals(other._unassigned, _unassigned) &&
            const DeepCollectionEquality()
                .equals(other._characters, _characters) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_unassigned),
      const DeepCollectionEquality().hash(_characters),
      isSaving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SkilltreeOverviewStateCopyWith<_$_SkilltreeOverviewState> get copyWith =>
      __$$_SkilltreeOverviewStateCopyWithImpl<_$_SkilltreeOverviewState>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SkilltreeOverviewStateToJson(
      this,
    );
  }
}

abstract class _SkilltreeOverviewState implements SkilltreeOverviewState {
  const factory _SkilltreeOverviewState(
      {final List<SkilltreeOverview> unassigned,
      final Map<String, List<SkilltreeOverview>> characters,
      final bool isSaving}) = _$_SkilltreeOverviewState;

  factory _SkilltreeOverviewState.fromJson(Map<String, dynamic> json) =
      _$_SkilltreeOverviewState.fromJson;

  @override
  List<SkilltreeOverview> get unassigned;
  @override
  Map<String, List<SkilltreeOverview>> get characters;
  @override
  bool get isSaving;
  @override
  @JsonKey(ignore: true)
  _$$_SkilltreeOverviewStateCopyWith<_$_SkilltreeOverviewState> get copyWith =>
      throw _privateConstructorUsedError;
}
