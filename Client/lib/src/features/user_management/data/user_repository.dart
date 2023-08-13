import 'package:kalinar/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/http/kalinar_http_client.dart';
import '../domain/group_member.dart';
import '../domain/user.dart';

part 'user_repository.g.dart';

class UserRepository {
  final KalinarHttpClient client;

  UserRepository(this.client);

  Future<User> getById(String groupId) async => client.get("$apiVersionPath/users/$groupId", (response) => User.fromJson(response));
  Future<List<GroupMember>> getGroupsById(String userId) async =>
      client.get("$apiVersionPath/users/$userId/groups", (response) => List<GroupMember>.from(response.map((model) => GroupMember.fromJson(model))));
  Future create(User user) async => client.post("$apiVersionPath/users", user, (response) => User.fromJson(response));
  Future update(String userId, User user) async => client.put("$apiVersionPath/users/$userId", user, (response) => User.fromJson(response));
  Future delete(String userId) async => client.delete("$apiVersionPath/users/$userId");
}

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepository(ref.watch(httpClientProvider));
}

@riverpod
FutureOr<User> getUserById(GetUserByIdRef ref, String userId) {
  return ref.watch(userRepositoryProvider).getById(userId);
}

@Riverpod(keepAlive: true)
FutureOr<List<GroupMember>> getUserGroupsById(GetUserGroupsByIdRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser!;
  return ref.watch(userRepositoryProvider).getGroupsById(user.uid);
}
