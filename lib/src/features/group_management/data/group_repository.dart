import 'dart:convert';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/domain/group_info.dart';
import 'package:hero/src/utilities/base_repository.dart';
import '../../authentication/data/auth_repository.dart';

import '../../../utilities/constants.dart';
import '../../authentication/domain/user_info.dart';
import '../domain/group.dart';

class GroupRepository extends BaseRepository {
  GroupRepository(FlutterAuth auth) : super(auth);

  Future<Group> getGroupInfo() async {
    final url = Uri.https(Constants.baseUrl, "/api/groups");
    return get(url, (response) => Group.fromJson(json.decode(response.body)));
  }

  Future<GroupInfo> getGroupInfoFromInviteCode(String code) async {
    final url = Uri.https(Constants.baseUrl, "/api/groups/$code");
    return await get(url, (response) => GroupInfo.fromJson(response));
  }

  Future<List<UserInfo>> getAllUsersInMyGroup() async {
    final url = Uri.https(Constants.baseUrl, "/api/groups/users");
    return get(url, (response) => List<UserInfo>.from(response.map((model) => UserInfo.fromJson(model))));
  }

  Future<void> createGroup(Map<String, dynamic> data) async {
    final url = Uri.https(Constants.baseUrl, "/api/groups");
    await post(url, data, (response) => true);
  }

  Future<void> joinGroup(String id, String code) async {
    final url = Uri.https(Constants.baseUrl, "/api/groups/$id/join/$code");
    await post(url, null, (response) => true);
  }
}

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  return GroupRepository(ref.read(authProvider));
});
