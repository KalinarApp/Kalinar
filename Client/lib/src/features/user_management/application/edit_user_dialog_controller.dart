import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/user_repository.dart';
import '../domain/user.dart';

part 'edit_user_dialog_controller.g.dart';

@riverpod
class EditUserDialogController extends _$EditUserDialogController {
  @override
  FutureOr<void> build() {}

  Future<bool> submit({String? userId, required User user}) async {
    state = const AsyncLoading().copyWithPrevious(state);

    final repository = ref.read(userRepositoryProvider);
    if (userId != null) {
      state = await AsyncValue.guard(() => repository.update(userId, user));
    } else {
      state = await AsyncValue.guard(() => repository.create(user));
    }

    ref.invalidate(getUserByIdProvider);
    return !state.hasError;
  }
}
