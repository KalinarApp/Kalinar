import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../user_management/data/user_repository.dart';
import '../data/groups_repository.dart';

part 'join_group_controller.g.dart';

@riverpod
class JoinGroupController extends _$JoinGroupController {
  @override
  FutureOr<void> build() {}

  Future<bool> join({required String groupId}) async {
    state = const AsyncLoading().copyWithPrevious(state);

    final repository = ref.read(groupRepositoryProvider);

    state = await AsyncValue.guard(() => repository.join(groupId));

    ref.invalidate(getUserGroupsByIdProvider);
    return !state.hasError;
  }
}
