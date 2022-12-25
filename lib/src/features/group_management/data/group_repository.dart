import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/group_management/application/group_notifier.dart';

import '../../../utilities/base_repository.dart';
import '../../authentication/domain/user_info.dart';
import '../domain/group.dart';
import '../domain/group_info.dart';

class GroupRepository extends HeroBaseRepository {
  GroupRepository({super.group});

  Future<Group> getGroupInfo() async {
    return await heroGet("/api/groups", (response) => Group.fromJson(response));
  }

  Future<GroupInfo> getGroupInfoFromInviteCode(String code) async {
    return await heroGet("/api/groups/$code", (response) => GroupInfo.fromJson(response));
  }

  Future<List<UserInfo>> getAllUsersInMyGroup() async {
    return await heroGet("/api/groups/users", (response) => List<UserInfo>.from(response.map((model) => UserInfo.fromJson(model))));
  }

  Future<void> createGroup(Map<String, dynamic> data) async {
    await heroPost("/api/groups", data, (response) => true);
  }

  Future<void> joinGroup(String id, String code) async {
    await heroPost("/api/groups/$id/join/$code", null, (response) => true);
  }
}

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  return GroupRepository(group: ref.watch(groupNotifierProvider).group);
});
