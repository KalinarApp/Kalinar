import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/auth_repository.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository authRepository;

  AuthController({required this.authRepository}) : super(const AsyncData(null));

  Future<void> signIn() async {
    await authRepository.login();
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.logout());
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>((ref) => AuthController(authRepository: ref.read(authRepositoryProvider)));
