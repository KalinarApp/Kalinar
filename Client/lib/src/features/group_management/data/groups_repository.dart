import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/http/kalinar_http_client.dart';
import '../domain/group.dart';
import '../domain/group_member.dart';

part 'groups_repository.g.dart';

class GroupRepository {
  final KalinarHttpClient client;

  GroupRepository(this.client);

  Future<Group> getById(String groupId) async => client.get("$apiVersionPath/groups/$groupId", (response) => Group.fromJson(response));
  Future<List<GroupMember>> getMembersById(String groupId) async => client.get(
      "$apiVersionPath/groups/$groupId/members", (response) => List<GroupMember>.from(response.map((model) => GroupMember.fromJson(model))));
  Future create(Group group) async => client.post("$apiVersionPath/groups", group, (response) => Group.fromJson(response));
  Future update(String groupId, Group group) async => client.put("$apiVersionPath/groups/$groupId", group, (response) => Group.fromJson(response));
  Future delete(String groupId) async => client.delete("$apiVersionPath/groups/$groupId");
}

@riverpod
GroupRepository groupRepository(GroupRepositoryRef ref) {
  return GroupRepository(ref.watch(httpClientProvider));
}

@riverpod
FutureOr<Group> getGroupById(GetGroupByIdRef ref, String groupId) {
  return ref.watch(groupRepositoryProvider).getById(groupId);
}

@riverpod
FutureOr<List<GroupMember>> getGroupMembersById(GetGroupMembersByIdRef ref, String groupId) {
  return ref.watch(groupRepositoryProvider).getMembersById(groupId);
}
