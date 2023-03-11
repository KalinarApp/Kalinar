import 'package:freezed_annotation/freezed_annotation.dart';

import 'group.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String username,
    Group? group,
    Group? ownedGroup,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
