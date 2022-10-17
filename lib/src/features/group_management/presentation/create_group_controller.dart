import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../data/group_repository.dart';

class CreateGroupController extends StateNotifier<AsyncValue<void>> {
  final GroupRepository repo;
  final buttonController = RoundedLoadingButtonController();

  CreateGroupController(this.repo) : super(const AsyncData(null));

  Future<void> save(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.createGroup(data));
  }

  void reset() {
    buttonController.reset();
  }
}

final createGroupControllerProvider = StateNotifierProvider.autoDispose<CreateGroupController, AsyncValue<void>>((ref) {
  return CreateGroupController(ref.read(groupRepositoryProvider));
});
