// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'create_skill_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CreateSkillState {
  Ability? get selectedAbility => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateSkillStateCopyWith<CreateSkillState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSkillStateCopyWith<$Res> {
  factory $CreateSkillStateCopyWith(
          CreateSkillState value, $Res Function(CreateSkillState) then) =
      _$CreateSkillStateCopyWithImpl<$Res, CreateSkillState>;
  @useResult
  $Res call({Ability? selectedAbility});

  $AbilityCopyWith<$Res>? get selectedAbility;
}

/// @nodoc
class _$CreateSkillStateCopyWithImpl<$Res, $Val extends CreateSkillState>
    implements $CreateSkillStateCopyWith<$Res> {
  _$CreateSkillStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedAbility = freezed,
  }) {
    return _then(_value.copyWith(
      selectedAbility: freezed == selectedAbility
          ? _value.selectedAbility
          : selectedAbility // ignore: cast_nullable_to_non_nullable
              as Ability?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AbilityCopyWith<$Res>? get selectedAbility {
    if (_value.selectedAbility == null) {
      return null;
    }

    return $AbilityCopyWith<$Res>(_value.selectedAbility!, (value) {
      return _then(_value.copyWith(selectedAbility: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CreateSkillStateCopyWith<$Res>
    implements $CreateSkillStateCopyWith<$Res> {
  factory _$$_CreateSkillStateCopyWith(
          _$_CreateSkillState value, $Res Function(_$_CreateSkillState) then) =
      __$$_CreateSkillStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Ability? selectedAbility});

  @override
  $AbilityCopyWith<$Res>? get selectedAbility;
}

/// @nodoc
class __$$_CreateSkillStateCopyWithImpl<$Res>
    extends _$CreateSkillStateCopyWithImpl<$Res, _$_CreateSkillState>
    implements _$$_CreateSkillStateCopyWith<$Res> {
  __$$_CreateSkillStateCopyWithImpl(
      _$_CreateSkillState _value, $Res Function(_$_CreateSkillState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedAbility = freezed,
  }) {
    return _then(_$_CreateSkillState(
      selectedAbility: freezed == selectedAbility
          ? _value.selectedAbility
          : selectedAbility // ignore: cast_nullable_to_non_nullable
              as Ability?,
    ));
  }
}

/// @nodoc

class _$_CreateSkillState implements _CreateSkillState {
  const _$_CreateSkillState({this.selectedAbility});

  @override
  final Ability? selectedAbility;

  @override
  String toString() {
    return 'CreateSkillState(selectedAbility: $selectedAbility)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateSkillState &&
            (identical(other.selectedAbility, selectedAbility) ||
                other.selectedAbility == selectedAbility));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedAbility);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateSkillStateCopyWith<_$_CreateSkillState> get copyWith =>
      __$$_CreateSkillStateCopyWithImpl<_$_CreateSkillState>(this, _$identity);
}

abstract class _CreateSkillState implements CreateSkillState {
  const factory _CreateSkillState({final Ability? selectedAbility}) =
      _$_CreateSkillState;

  @override
  Ability? get selectedAbility;
  @override
  @JsonKey(ignore: true)
  _$$_CreateSkillStateCopyWith<_$_CreateSkillState> get copyWith =>
      throw _privateConstructorUsedError;
}
