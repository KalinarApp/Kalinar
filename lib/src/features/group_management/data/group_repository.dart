import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/domain/group_info.dart';
import 'package:hero/src/utilities/base_repository.dart';
import '../../authentication/data/auth_repository.dart';

import '../../authentication/domain/user_info.dart';
import '../domain/group.dart';

class GroupRepository extends HeroBaseRepository {
  GroupRepository(super.client);

  Future<Group> getGroupInfo() async {
    return heroGet("/api/groups", (response) => Group.fromJson(json.decode(response.body)));
  }

  Future<GroupInfo> getGroupInfoFromInviteCode(String code) async {
    return await heroGet("/api/groups/$code", (response) => GroupInfo.fromJson(response));
  }

  Future<List<UserInfo>> getAllUsersInMyGroup() async {
    return heroGet("/api/groups/users", (response) => List<UserInfo>.from(response.map((model) => UserInfo.fromJson(model))));
  }

  Future<void> createGroup(Map<String, dynamic> data) async {
    await heroPost("/api/groups", data, (response) => true);
  }

  Future<void> joinGroup(String id, String code) async {
    await heroPost("/api/groups/$id/join/$code", null, (response) => true);
  }
}

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  return GroupRepository(ref.read(authProvider));
});
