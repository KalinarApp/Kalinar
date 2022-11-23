// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'skilltree_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SkilltreeState _$SkilltreeStateFromJson(Map<String, dynamic> json) {
  return _SkilltreeState.fromJson(json);
}

/// @nodoc
mixin _$SkilltreeState {
  String? get id => throw _privateConstructorUsedError;
  Skilltree get skilltree => throw _privateConstructorUsedError;
  bool get isBlueprint => throw _privateConstructorUsedError;
  Node? get selectedNode => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkilltreeStateCopyWith<SkilltreeState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkilltreeStateCopyWith<$Res> {
  factory $SkilltreeStateCopyWith(SkilltreeState value, $Res Function(SkilltreeState) then) = _$SkilltreeStateCopyWithImpl<$Res, SkilltreeState>;
  @useResult
  $Res call({String? id, Skilltree skilltree, bool isBlueprint, Node? selectedNode, bool isSaving});

  $SkilltreeCopyWith<$Res> get skilltree;
  $NodeCopyWith<$Res>? get selectedNode;
}

/// @nodoc
class _$SkilltreeStateCopyWithImpl<$Res, $Val extends SkilltreeState> implements $SkilltreeStateCopyWith<$Res> {
  _$SkilltreeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? skilltree = null,
    Object? isBlueprint = null,
    Object? selectedNode = freezed,
    Object? isSaving = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      skilltree: null == skilltree
          ? _value.skilltree
          : skilltree // ignore: cast_nullable_to_non_nullable
              as Skilltree,
      isBlueprint: null == isBlueprint
          ? _value.isBlueprint
          : isBlueprint // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedNode: freezed == selectedNode
          ? _value.selectedNode
          : selectedNode // ignore: cast_nullable_to_non_nullable
              as Node?,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SkilltreeCopyWith<$Res> get skilltree {
    return $SkilltreeCopyWith<$Res>(_value.skilltree, (value) {
      return _then(_value.copyWith(skilltree: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $NodeCopyWith<$Res>? get selectedNode {
    if (_value.selectedNode == null) {
      return null;
    }

    return $NodeCopyWith<$Res>(_value.selectedNode!, (value) {
      return _then(_value.copyWith(selectedNode: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SkilltreeStateCopyWith<$Res> implements $SkilltreeStateCopyWith<$Res> {
  factory _$$_SkilltreeStateCopyWith(_$_SkilltreeState value, $Res Function(_$_SkilltreeState) then) = __$$_SkilltreeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, Skilltree skilltree, bool isBlueprint, Node? selectedNode, bool isSaving});

  @override
  $SkilltreeCopyWith<$Res> get skilltree;
  @override
  $NodeCopyWith<$Res>? get selectedNode;
}

/// @nodoc
class __$$_SkilltreeStateCopyWithImpl<$Res> extends _$SkilltreeStateCopyWithImpl<$Res, _$_SkilltreeState>
    implements _$$_SkilltreeStateCopyWith<$Res> {
  __$$_SkilltreeStateCopyWithImpl(_$_SkilltreeState _value, $Res Function(_$_SkilltreeState) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? skilltree = null,
    Object? isBlueprint = null,
    Object? selectedNode = freezed,
    Object? isSaving = null,
  }) {
    return _then(_$_SkilltreeState(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      skilltree: null == skilltree
          ? _value.skilltree
          : skilltree // ignore: cast_nullable_to_non_nullable
              as Skilltree,
      isBlueprint: null == isBlueprint
          ? _value.isBlueprint
          : isBlueprint // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedNode: freezed == selectedNode
          ? _value.selectedNode
          : selectedNode // ignore: cast_nullable_to_non_nullable
              as Node?,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SkilltreeState implements _SkilltreeState {
  const _$_SkilltreeState({this.id, this.skilltree = const Skilltree(), this.isBlueprint = false, this.selectedNode, this.isSaving = false});

  factory _$_SkilltreeState.fromJson(Map<String, dynamic> json) => _$$_SkilltreeStateFromJson(json);

  @override
  final String? id;
  @override
  @JsonKey()
  final Skilltree skilltree;
  @override
  @JsonKey()
  final bool isBlueprint;
  @override
  final Node? selectedNode;
  @override
  @JsonKey()
  final bool isSaving;

  @override
  String toString() {
    return 'SkilltreeState(id: $id, skilltree: $skilltree, isBlueprint: $isBlueprint, selectedNode: $selectedNode, isSaving: $isSaving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SkilltreeState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.skilltree, skilltree) || other.skilltree == skilltree) &&
            (identical(other.isBlueprint, isBlueprint) || other.isBlueprint == isBlueprint) &&
            (identical(other.selectedNode, selectedNode) || other.selectedNode == selectedNode) &&
            (identical(other.isSaving, isSaving) || other.isSaving == isSaving));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, skilltree, isBlueprint, selectedNode, isSaving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SkilltreeStateCopyWith<_$_SkilltreeState> get copyWith => __$$_SkilltreeStateCopyWithImpl<_$_SkilltreeState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SkilltreeStateToJson(
      this,
    );
  }
}

abstract class _SkilltreeState implements SkilltreeState {
  const factory _SkilltreeState(
      {final String? id, final Skilltree skilltree, final bool isBlueprint, final Node? selectedNode, final bool isSaving}) = _$_SkilltreeState;

  factory _SkilltreeState.fromJson(Map<String, dynamic> json) = _$_SkilltreeState.fromJson;

  @override
  String? get id;
  @override
  Skilltree get skilltree;
  @override
  bool get isBlueprint;
  @override
  Node? get selectedNode;
  @override
  bool get isSaving;
  @override
  @JsonKey(ignore: true)
  _$$_SkilltreeStateCopyWith<_$_SkilltreeState> get copyWith => throw _privateConstructorUsedError;
}
