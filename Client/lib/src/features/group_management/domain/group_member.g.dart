// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GroupMember _$$_GroupMemberFromJson(Map<String, dynamic> json) =>
    _$_GroupMember(
      Group.fromJson(json['group'] as Map<String, dynamic>),
      User.fromJson(json['user'] as Map<String, dynamic>),
      $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$$_GroupMemberToJson(_$_GroupMember instance) =>
    <String, dynamic>{
      'group': instance.group,
      'user': instance.user,
      'role': _$RoleEnumMap[instance.role]!,
    };

const _$RoleEnumMap = {
  Role.owner: 'Owner',
  Role.administrator: 'Administrator',
  Role.member: 'Member',
};
