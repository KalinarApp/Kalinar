import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/application/has_group_controller.dart';

import '../data/group_repository.dart';

class GroupController {
  final GroupRepository repo;
  final HasGroupController hasGroup;

  GroupController(this.repo, this.hasGroup);

  Future<AsyncValue<void>> save(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.createGroup(data);
      await hasGroup.check();
    });
  }
}

final groupControllerProvider = Provider((ref) {
  return GroupController(ref.read(groupRepositoryProvider), ref.read(hasGroupProvider));
});
