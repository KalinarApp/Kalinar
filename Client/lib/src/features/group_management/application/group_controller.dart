import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/group_management/data/user_repository.dart';

import '../data/group_repository.dart';
import '../domain/user.dart';
import 'group_notifier.dart';

class GroupController {
  final GroupRepository repo;
  final UserRepository userRepo;
  final GroupNotifier notifier;

  GroupController(this.repo, this.userRepo, this.notifier);

  Future<AsyncValue<void>> save(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.createGroup(data);
      await check();
    });
  }

  // Future<bool> hasGroup() async {
  //   User user = await userRepo.getUser();
  //   notifier.updateGroup(user.group);
  //   return null != user.group;
  // }

  Future<void> check() async {
    User user = await userRepo.getUser();
    notifier.updateGroup(user.group);
  }
}

final groupControllerProvider = Provider((ref) {
  return GroupController(ref.watch(groupRepositoryProvider), ref.watch(userRepositoryProvider), ref.watch(groupNotifierProvider));
});
