import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utilities/constants.dart';

part 'user_info.freezed.dart';
part 'user_info.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required String id,
    required String firstname,
    required String lastname,
    required String email,
    required String username,
    @Default([]) final List<String> roles,
    @Default([]) List<String> groups,
  }) = _UserInfo;

  factory UserInfo.fromJson(Map<String, dynamic> json) => _$UserInfoFromJson(json);

  factory UserInfo.fromAccessToken(Map<String, dynamic> json) => UserInfo(
      id: json['sub'],
      firstname: json['given_name'],
      lastname: json['family_name'],
      email: json['email'],
      username: json['preferred_username'],
      roles: List<String>.from(json['roles'].map((item) => item as String)));
}

extension UserInfoExtensions on UserInfo {
  bool isUser() {
    return roles.contains(Constants.userRoleName);
  }

  bool isAdmin() {
    return isUser() && roles.contains(Constants.adminRoleName);
  }
}
