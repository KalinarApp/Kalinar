import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/authentication/application/user_notifier.dart';

import '../../group_management/data/user_repository.dart';
import '../../group_management/domain/user.dart';

class UserController {
  final UserRepository repo;
  final UserNotifier notifier;

  UserController(this.repo, this.notifier);

  Future<void> getCurrentUser() async {
    User user = await repo.getUser();
    notifier.updateGroup(user);
  }
}

final userControllerProvider = Provider((ref) {
  return UserController(ref.watch(userRepositoryProvider), ref.watch(userNotifierProvider));
});
