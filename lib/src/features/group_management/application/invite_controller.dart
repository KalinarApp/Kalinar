import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/application/has_group_controller.dart';
import 'package:hero/src/features/group_management/data/group_repository.dart';

import '../domain/group_info.dart';

class InviteController extends StateNotifier<AsyncValue<GroupInfo>> {
  final GroupRepository repo;
  final HasGroupController hasGroup;

  InviteController(this.repo, this.hasGroup) : super(const AsyncLoading());

  Future<void> getInfo(String code) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.getGroupInfoFromInviteCode(code));
  }

  Future<AsyncValue<void>> joinGroup(String id, String code) async {
    return await AsyncValue.guard(() async {
      await repo.joinGroup(id, code);
      await hasGroup.check();
    });
  }
}

final inviteControllerProvider = StateNotifierProvider<InviteController, AsyncValue<GroupInfo>>((ref) {
  return InviteController(ref.read(groupRepositoryProvider), ref.read(hasGroupProvider));
});
