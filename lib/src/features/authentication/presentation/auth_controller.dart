import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/hero_api.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  final FlutterAuth authRepository;

  AuthController({required this.authRepository}) : super(const AsyncData(null));

  Future<void> initialize() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.init);
  }

  Future<void> signIn() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.login);
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.logout);
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<void>>((ref) => AuthController(authRepository: ref.watch(authProvider)));
