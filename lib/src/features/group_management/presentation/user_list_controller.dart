import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/domain/user.dart';
import '../data/group_repository.dart';

class UserListController extends StateNotifier<AsyncValue<List<User>>> {
  final GroupRepository repo;

  UserListController(this.repo) : super(const AsyncData([]));

  Future<void> getMembers() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(repo.getAllUsersInMyGroup);
  }
}

final userListControllerProvider = StateNotifierProvider<UserListController, AsyncValue<List<User>>>((ref) {
  return UserListController(ref.read(groupRepositoryProvider));
});
