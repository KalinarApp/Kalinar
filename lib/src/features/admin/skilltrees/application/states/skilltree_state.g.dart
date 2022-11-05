// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skilltree_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SkilltreeState _$$_SkilltreeStateFromJson(Map<String, dynamic> json) =>
    _$_SkilltreeState(
      skilltree: json['skilltree'] == null
          ? const Skilltree()
          : Skilltree.fromJson(json['skilltree'] as Map<String, dynamic>),
      selectedNode: json['selectedNode'] == null
          ? null
          : Node.fromJson(json['selectedNode'] as Map<String, dynamic>),
      isSaving: json['isSaving'] as bool? ?? false,
    );

Map<String, dynamic> _$$_SkilltreeStateToJson(_$_SkilltreeState instance) =>
    <String, dynamic>{
      'skilltree': instance.skilltree,
      'selectedNode': instance.selectedNode,
      'isSaving': instance.isSaving,
    };
