import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/group_management/application/group_controller.dart';

import '../data/auth_repository.dart';

class InitController {
  final AuthRepository authRepository;
  final GroupController groups;

  InitController(this.authRepository, this.groups);

  Future<AsyncValue> initialize() async {
    return AsyncValue.guard(() async {
      if (await authRepository.init()) {
        await groups.check();
      }
    });
  }
}

final initControllerProvider =
    Provider<InitController>((ref) => InitController(ref.watch(authRepositoryProvider), ref.watch(groupControllerProvider)));
