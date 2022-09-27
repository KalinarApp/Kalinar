import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/hero_api.dart';

class AuthController {
  final FlutterAuth authRepository;

  AuthController({required this.authRepository});

  Future<void> signIn() async {
    await authRepository.login();
  }

  Future<void> signOut() async {
    await authRepository.logout();
  }
}

final authControllerProvider = Provider<AuthController>((ref) => AuthController(authRepository: ref.read(authProvider)));
