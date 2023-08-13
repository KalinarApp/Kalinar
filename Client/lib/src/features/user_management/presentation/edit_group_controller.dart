import 'package:kalinar/src/features/user_management/data/groups_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/group.dart';

part 'edit_group_controller.g.dart';

@riverpod
class EditGroupController extends _$EditGroupController {
  @override
  FutureOr<void> build() {}

  Future<bool> submit({String? groupId, required Group group}) async {
    state = const AsyncLoading().copyWithPrevious(state);

    final repository = ref.read(groupRepositoryProvider);
    if (groupId != null) {
      state = await AsyncValue.guard(() => repository.update(groupId, group));
    } else {
      state = await AsyncValue.guard(() => repository.create(group));
    }

    return !state.hasError;
  }
}
