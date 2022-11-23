// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'skillpoints.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Skillpoints _$SkillpointsFromJson(Map<String, dynamic> json) {
  return _Skillpoints.fromJson(json);
}

/// @nodoc
mixin _$Skillpoints {
  int get currentSkillpoints => throw _privateConstructorUsedError;
  int get maxSkillpoints => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkillpointsCopyWith<Skillpoints> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillpointsCopyWith<$Res> {
  factory $SkillpointsCopyWith(Skillpoints value, $Res Function(Skillpoints) then) = _$SkillpointsCopyWithImpl<$Res, Skillpoints>;
  @useResult
  $Res call({int currentSkillpoints, int maxSkillpoints, String? iconUrl});
}

/// @nodoc
class _$SkillpointsCopyWithImpl<$Res, $Val extends Skillpoints> implements $SkillpointsCopyWith<$Res> {
  _$SkillpointsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSkillpoints = null,
    Object? maxSkillpoints = null,
    Object? iconUrl = freezed,
  }) {
    return _then(_value.copyWith(
      currentSkillpoints: null == currentSkillpoints
          ? _value.currentSkillpoints
          : currentSkillpoints // ignore: cast_nullable_to_non_nullable
              as int,
      maxSkillpoints: null == maxSkillpoints
          ? _value.maxSkillpoints
          : maxSkillpoints // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SkillpointsCopyWith<$Res> implements $SkillpointsCopyWith<$Res> {
  factory _$$_SkillpointsCopyWith(_$_Skillpoints value, $Res Function(_$_Skillpoints) then) = __$$_SkillpointsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int currentSkillpoints, int maxSkillpoints, String? iconUrl});
}

/// @nodoc
class __$$_SkillpointsCopyWithImpl<$Res> extends _$SkillpointsCopyWithImpl<$Res, _$_Skillpoints> implements _$$_SkillpointsCopyWith<$Res> {
  __$$_SkillpointsCopyWithImpl(_$_Skillpoints _value, $Res Function(_$_Skillpoints) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSkillpoints = null,
    Object? maxSkillpoints = null,
    Object? iconUrl = freezed,
  }) {
    return _then(_$_Skillpoints(
      currentSkillpoints: null == currentSkillpoints
          ? _value.currentSkillpoints
          : currentSkillpoints // ignore: cast_nullable_to_non_nullable
              as int,
      maxSkillpoints: null == maxSkillpoints
          ? _value.maxSkillpoints
          : maxSkillpoints // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Skillpoints implements _Skillpoints {
  const _$_Skillpoints({this.currentSkillpoints = 0, this.maxSkillpoints = 0, this.iconUrl});

  factory _$_Skillpoints.fromJson(Map<String, dynamic> json) => _$$_SkillpointsFromJson(json);

  @override
  @JsonKey()
  final int currentSkillpoints;
  @override
  @JsonKey()
  final int maxSkillpoints;
  @override
  final String? iconUrl;

  @override
  String toString() {
    return 'Skillpoints(currentSkillpoints: $currentSkillpoints, maxSkillpoints: $maxSkillpoints, iconUrl: $iconUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Skillpoints &&
            (identical(other.currentSkillpoints, currentSkillpoints) || other.currentSkillpoints == currentSkillpoints) &&
            (identical(other.maxSkillpoints, maxSkillpoints) || other.maxSkillpoints == maxSkillpoints) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currentSkillpoints, maxSkillpoints, iconUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SkillpointsCopyWith<_$_Skillpoints> get copyWith => __$$_SkillpointsCopyWithImpl<_$_Skillpoints>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SkillpointsToJson(
      this,
    );
  }
}

abstract class _Skillpoints implements Skillpoints {
  const factory _Skillpoints({final int currentSkillpoints, final int maxSkillpoints, final String? iconUrl}) = _$_Skillpoints;

  factory _Skillpoints.fromJson(Map<String, dynamic> json) = _$_Skillpoints.fromJson;

  @override
  int get currentSkillpoints;
  @override
  int get maxSkillpoints;
  @override
  String? get iconUrl;
  @override
  @JsonKey(ignore: true)
  _$$_SkillpointsCopyWith<_$_Skillpoints> get copyWith => throw _privateConstructorUsedError;
}
