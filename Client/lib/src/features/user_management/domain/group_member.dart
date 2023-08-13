import 'package:freezed_annotation/freezed_annotation.dart';

import 'group.dart';
import 'role.dart';
import 'user.dart';

part 'group_member.freezed.dart';
part 'group_member.g.dart';

@freezed
class GroupMember with _$GroupMember {
  factory GroupMember(
    Group group,
    User user,
    Role role,
  ) = _GroupMember;

  factory GroupMember.fromJson(Map<String, dynamic> json) => _$GroupMemberFromJson(json);
}
