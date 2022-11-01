import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/application/has_group_controller.dart';

import '../data/auth_repository.dart';

class InitController {
  final AuthRepository authRepository;
  final HasGroupController hasGroupController;

  InitController(this.authRepository, this.hasGroupController);

  Future<void> initialize() async {
    if (await authRepository.init()) {
      hasGroupController.check();
    }
  }
}

final initControllerProvider =
    Provider<InitController>((ref) => InitController(ref.read(authRepositoryProvider), ref.read(hasGroupProvider.notifier)));
