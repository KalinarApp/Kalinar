// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthState _$$_AuthStateFromJson(Map<String, dynamic> json) => _$_AuthState(
      isAuthenticated: json['isAuthenticated'] as bool?,
      user: json['user'] == null
          ? null
          : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AuthStateToJson(_$_AuthState instance) =>
    <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
      'user': instance.user,
    };
