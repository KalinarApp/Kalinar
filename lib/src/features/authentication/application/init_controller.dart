import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';

class InitController {
  final AuthRepository authRepository;

  InitController(this.authRepository);

  Future<void> initialize() async {
    await authRepository.init();
  }
}

final initControllerProvider = Provider<InitController>((ref) => InitController(ref.read(authRepositoryProvider)));
