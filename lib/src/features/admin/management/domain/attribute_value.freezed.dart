// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'attribute_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AttributeValue _$AttributeValueFromJson(Map<String, dynamic> json) {
  return _AttributeValue.fromJson(json);
}

/// @nodoc
mixin _$AttributeValue {
  String get attributeId => throw _privateConstructorUsedError;
  Attribute get attribute => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttributeValueCopyWith<AttributeValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeValueCopyWith<$Res> {
  factory $AttributeValueCopyWith(
          AttributeValue value, $Res Function(AttributeValue) then) =
      _$AttributeValueCopyWithImpl<$Res, AttributeValue>;
  @useResult
  $Res call({String attributeId, Attribute attribute, double value});

  $AttributeCopyWith<$Res> get attribute;
}

/// @nodoc
class _$AttributeValueCopyWithImpl<$Res, $Val extends AttributeValue>
    implements $AttributeValueCopyWith<$Res> {
  _$AttributeValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributeId = null,
    Object? attribute = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      attributeId: null == attributeId
          ? _value.attributeId
          : attributeId // ignore: cast_nullable_to_non_nullable
              as String,
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Attribute,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttributeCopyWith<$Res> get attribute {
    return $AttributeCopyWith<$Res>(_value.attribute, (value) {
      return _then(_value.copyWith(attribute: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AttributeValueCopyWith<$Res>
    implements $AttributeValueCopyWith<$Res> {
  factory _$$_AttributeValueCopyWith(
          _$_AttributeValue value, $Res Function(_$_AttributeValue) then) =
      __$$_AttributeValueCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String attributeId, Attribute attribute, double value});

  @override
  $AttributeCopyWith<$Res> get attribute;
}

/// @nodoc
class __$$_AttributeValueCopyWithImpl<$Res>
    extends _$AttributeValueCopyWithImpl<$Res, _$_AttributeValue>
    implements _$$_AttributeValueCopyWith<$Res> {
  __$$_AttributeValueCopyWithImpl(
      _$_AttributeValue _value, $Res Function(_$_AttributeValue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attributeId = null,
    Object? attribute = null,
    Object? value = null,
  }) {
    return _then(_$_AttributeValue(
      attributeId: null == attributeId
          ? _value.attributeId
          : attributeId // ignore: cast_nullable_to_non_nullable
              as String,
      attribute: null == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as Attribute,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AttributeValue implements _AttributeValue {
  const _$_AttributeValue(
      {required this.attributeId,
      required this.attribute,
      required this.value});

  factory _$_AttributeValue.fromJson(Map<String, dynamic> json) =>
      _$$_AttributeValueFromJson(json);

  @override
  final String attributeId;
  @override
  final Attribute attribute;
  @override
  final double value;

  @override
  String toString() {
    return 'AttributeValue(attributeId: $attributeId, attribute: $attribute, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttributeValue &&
            (identical(other.attributeId, attributeId) ||
                other.attributeId == attributeId) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, attributeId, attribute, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttributeValueCopyWith<_$_AttributeValue> get copyWith =>
      __$$_AttributeValueCopyWithImpl<_$_AttributeValue>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttributeValueToJson(
      this,
    );
  }
}

abstract class _AttributeValue implements AttributeValue {
  const factory _AttributeValue(
      {required final String attributeId,
      required final Attribute attribute,
      required final double value}) = _$_AttributeValue;

  factory _AttributeValue.fromJson(Map<String, dynamic> json) =
      _$_AttributeValue.fromJson;

  @override
  String get attributeId;
  @override
  Attribute get attribute;
  @override
  double get value;
  @override
  @JsonKey(ignore: true)
  _$$_AttributeValueCopyWith<_$_AttributeValue> get copyWith =>
      throw _privateConstructorUsedError;
}
