import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/data/user_repository.dart';

import '../data/group_repository.dart';

class GroupController {
  final GroupRepository repo;
  final UserRepository userRepo;

  GroupController(this.repo, this.userRepo);

  Future<AsyncValue<void>> save(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() => repo.createGroup(data));
  }

  Future<bool> hasGroup() async {
    final user = await userRepo.getUser();
    return null != user.group;
  }
}

final groupControllerProvider = Provider((ref) {
  return GroupController(ref.read(groupRepositoryProvider), ref.read(userRepositoryProvider));
});

final hasGroupProvider = FutureProvider<bool>((ref) => ref.watch(groupControllerProvider).hasGroup());
