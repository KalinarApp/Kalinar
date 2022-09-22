import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/authentication_repository.dart';

import '../../../utilities/hero_api.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthenticationRepository authRepository;

  AuthController({required this.authRepository}) : super(const AsyncData<void>(null));

  Future<void> signIn() async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(authRepository.login);
  }

  Future<void> signOut() async {
    state = const AsyncLoading<void>();
    state = await AsyncValue.guard(authRepository.logout);
  }
}

final authControllerProvider = StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>(
  (ref) => AuthController(authRepository: ref.watch(authenticationRepositoryProvider)),
);

final loginStateChangedProvider = StateNotifierProvider.autoDispose<bool>((ref) {
  return ref.watch(flutterAuthProvider).isLoggedIn;
});
