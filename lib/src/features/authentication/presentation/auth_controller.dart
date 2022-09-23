import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/authentication_repository.dart';
import 'package:hero/src/features/authentication/presentation/auth_state.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;

  AuthController({required this.authRepository}) : super(AuthState(isAuthenticated: authRepository.authClient.isLoggedIn));

  Future<void> signIn() async {
    final user = await authRepository.login();
    state.copyWith(user: user, isAuthenticated: null != user);
  }

  Future<void> signOut() async {
    authRepository.logout();
    state.copyWith(user: null, isAuthenticated: false);
  }
}

final authControllerProvider = StateNotifierProvider.autoDispose<AuthController, AuthState>(
  (ref) => AuthController(authRepository: ref.watch(authenticationRepositoryProvider)),
);
