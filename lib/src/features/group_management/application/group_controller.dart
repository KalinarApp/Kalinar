import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/group_repository.dart';

class GroupController {
  final GroupRepository repo;

  GroupController(this.repo);

  Future<AsyncValue<void>> save(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async => await repo.createGroup(data));
  }
}

final groupControllerProvider = Provider((ref) {
  return GroupController(ref.read(groupRepositoryProvider));
});
