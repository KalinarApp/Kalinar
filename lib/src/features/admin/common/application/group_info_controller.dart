import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../group_management/data/group_repository.dart';
import '../../../group_management/domain/group.dart';

class GroupInfoController extends StateNotifier<AsyncValue<Group?>> {
  final GroupRepository repo;
  final controller = TextEditingController();

  GroupInfoController(this.repo) : super(const AsyncData(null));

  Future<void> getInfo() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => repo.getGroupInfo());
    if (state.hasValue && null != state.value) {
      controller.text = state.value!.code ?? "";
    }
  }
}

final groupInfoControllerProvider = StateNotifierProvider<GroupInfoController, AsyncValue<Group?>>((ref) {
  return GroupInfoController(ref.read(groupRepositoryProvider));
});
