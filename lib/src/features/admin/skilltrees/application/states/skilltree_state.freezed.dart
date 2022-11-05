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
  List<Node> get nodes => throw _privateConstructorUsedError;
  Node? get selectedNode => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkilltreeStateCopyWith<SkilltreeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkilltreeStateCopyWith<$Res> {
  factory $SkilltreeStateCopyWith(
          SkilltreeState value, $Res Function(SkilltreeState) then) =
      _$SkilltreeStateCopyWithImpl<$Res, SkilltreeState>;
  @useResult
  $Res call({List<Node> nodes, Node? selectedNode, bool isSaving});

  $NodeCopyWith<$Res>? get selectedNode;
}

/// @nodoc
class _$SkilltreeStateCopyWithImpl<$Res, $Val extends SkilltreeState>
    implements $SkilltreeStateCopyWith<$Res> {
  _$SkilltreeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? selectedNode = freezed,
    Object? isSaving = null,
  }) {
    return _then(_value.copyWith(
      nodes: null == nodes
          ? _value.nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Node>,
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
abstract class _$$_SkilltreeStateCopyWith<$Res>
    implements $SkilltreeStateCopyWith<$Res> {
  factory _$$_SkilltreeStateCopyWith(
          _$_SkilltreeState value, $Res Function(_$_SkilltreeState) then) =
      __$$_SkilltreeStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Node> nodes, Node? selectedNode, bool isSaving});

  @override
  $NodeCopyWith<$Res>? get selectedNode;
}

/// @nodoc
class __$$_SkilltreeStateCopyWithImpl<$Res>
    extends _$SkilltreeStateCopyWithImpl<$Res, _$_SkilltreeState>
    implements _$$_SkilltreeStateCopyWith<$Res> {
  __$$_SkilltreeStateCopyWithImpl(
      _$_SkilltreeState _value, $Res Function(_$_SkilltreeState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodes = null,
    Object? selectedNode = freezed,
    Object? isSaving = null,
  }) {
    return _then(_$_SkilltreeState(
      nodes: null == nodes
          ? _value._nodes
          : nodes // ignore: cast_nullable_to_non_nullable
              as List<Node>,
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
  const _$_SkilltreeState(
      {final List<Node> nodes = const [],
      this.selectedNode,
      this.isSaving = false})
      : _nodes = nodes;

  factory _$_SkilltreeState.fromJson(Map<String, dynamic> json) =>
      _$$_SkilltreeStateFromJson(json);

  final List<Node> _nodes;
  @override
  @JsonKey()
  List<Node> get nodes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodes);
  }

  @override
  final Node? selectedNode;
  @override
  @JsonKey()
  final bool isSaving;

  @override
  String toString() {
    return 'SkilltreeState(nodes: $nodes, selectedNode: $selectedNode, isSaving: $isSaving)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SkilltreeState &&
            const DeepCollectionEquality().equals(other._nodes, _nodes) &&
            (identical(other.selectedNode, selectedNode) ||
                other.selectedNode == selectedNode) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_nodes), selectedNode, isSaving);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SkilltreeStateCopyWith<_$_SkilltreeState> get copyWith =>
      __$$_SkilltreeStateCopyWithImpl<_$_SkilltreeState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SkilltreeStateToJson(
      this,
    );
  }
}

abstract class _SkilltreeState implements SkilltreeState {
  const factory _SkilltreeState(
      {final List<Node> nodes,
      final Node? selectedNode,
      final bool isSaving}) = _$_SkilltreeState;

  factory _SkilltreeState.fromJson(Map<String, dynamic> json) =
      _$_SkilltreeState.fromJson;

  @override
  List<Node> get nodes;
  @override
  Node? get selectedNode;
  @override
  bool get isSaving;
  @override
  @JsonKey(ignore: true)
  _$$_SkilltreeStateCopyWith<_$_SkilltreeState> get copyWith =>
      throw _privateConstructorUsedError;
}
