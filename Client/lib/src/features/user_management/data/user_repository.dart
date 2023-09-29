import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../constants/storage_key.dart';
import '../../../utils/http/kalinar_http_client.dart';
import '../../../utils/local_storage/shared_preferences_helper.dart';
import '../../authentication/data/firebase_auth_repository.dart';
import '../../group_management/domain/group_member.dart';
import '../../group_management/domain/role.dart';
import '../domain/user.dart';

part 'user_repository.g.dart';

class UserRepository {
  final KalinarHttpClient client;

  UserRepository(this.client);

  Future<User> getById(String groupId) async => client.get("$apiVersionPath/users/$groupId", (response) => User.fromJson(response));
  Future<List<GroupMember>> getGroupsById(String userId) async =>
      client.get("$apiVersionPath/users/$userId/groups", (response) => List<GroupMember>.from(response.map((model) => GroupMember.fromJson(model))));
  Future create(User user) async => client.post("$apiVersionPath/users/register", user, (response) => User.fromJson(response));
  Future update(String userId, User user) async => client.put("$apiVersionPath/users/$userId", user, (response) => User.fromJson(response));
  Future delete(String userId) async => client.delete("$apiVersionPath/users/$userId");
}

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(ref.watch(httpClientProvider));
}

@riverpod
FutureOr<User> getCurrentUser(GetCurrentUserRef ref) {
  final userId = ref.watch(firebaseAuthProvider).currentUser!.uid;
  return ref.watch(userRepositoryProvider).getById(userId);
}

@riverpod
FutureOr<User> getUserById(GetUserByIdRef ref, String userId) {
  return ref.watch(userRepositoryProvider).getById(userId);
}

@riverpod
FutureOr<List<GroupMember>> getUserGroupsById(GetUserGroupsByIdRef ref) {
  final userId = ref.watch(firebaseAuthProvider).currentUser!.uid;
  return ref.watch(userRepositoryProvider).getGroupsById(userId);
}

@riverpod
FutureOr<GroupMember?> getSelectedGroup(GetSelectedGroupRef ref) {
  final groups = ref.watch(getUserGroupsByIdProvider);
  if (!groups.hasValue || groups.value!.isEmpty) return null;

  final groupId = ref.watch(getSharedPreferencesProvider).getString(StorageKey.defaultGroupId);
  final selectedGroup = groupId != null ? groups.value!.firstWhereOrNull((element) => element.group.id == groupId) : null;
  final currentGroup = selectedGroup ?? groups.value!.firstOrNull;

  return currentGroup;
}

@riverpod
bool isAdminInSelectedGroup(IsAdminInSelectedGroupRef ref) {
  final selectedGroup = ref.watch(getSelectedGroupProvider);
  return selectedGroup.hasValue ? selectedGroup.value!.role.isAdminRole : false;
}
