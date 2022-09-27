import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/hero_api.dart';

class InitController {
  final FlutterAuth authRepository;

  InitController(this.authRepository);

  Future<void> initialize() async {
    await authRepository.init();
  }
}

final initControllerProvider = Provider<InitController>((ref) => InitController(ref.read(authProvider)));
