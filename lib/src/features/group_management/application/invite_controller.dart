import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/group_management/application/group_controller.dart';

import '../data/group_repository.dart';
import '../domain/group_info.dart';

class InviteController extends StateNotifier<AsyncValue<GroupInfo>> {
  final GroupRepository repo;
  final GroupController groups;

  InviteController(this.repo, this.groups) : super(const AsyncLoading());

  Future<void> getInfo(String code) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.getGroupInfoFromInviteCode(code));
  }

  Future<AsyncValue<void>> joinGroup(String id, String code) async {
    return await AsyncValue.guard(() async {
      await repo.joinGroup(id, code);
    });
  }
}

final inviteControllerProvider = StateNotifierProvider<InviteController, AsyncValue<GroupInfo>>((ref) {
  return InviteController(ref.watch(groupRepositoryProvider), ref.watch(groupControllerProvider));
});
