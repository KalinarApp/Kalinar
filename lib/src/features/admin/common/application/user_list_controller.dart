import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../authentication/domain/user_info.dart';
import '../../../group_management/data/group_repository.dart';

class UserListController extends StateNotifier<AsyncValue<List<UserInfo>>> {
  final GroupRepository repo;

  UserListController(this.repo) : super(const AsyncData([]));

  Future<void> getMembers() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(repo.getAllUsersInMyGroup);
  }
}

final userListControllerProvider = StateNotifierProvider<UserListController, AsyncValue<List<UserInfo>>>((ref) {
  return UserListController(ref.watch(groupRepositoryProvider));
});
