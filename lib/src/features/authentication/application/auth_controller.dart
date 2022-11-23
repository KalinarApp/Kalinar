import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../group_management/application/has_group_controller.dart';

import '../data/auth_repository.dart';

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository authRepository;
  final HasGroupController hasGroupController;

  AuthController({required this.authRepository, required this.hasGroupController}) : super(const AsyncData(null));

  Future<AsyncValue<bool>> signIn({String? username, String? password}) async {
    return await AsyncValue.guard(() async {
      final success = await authRepository.login(username: username, password: password);
      if (success) {
        await hasGroupController.check();
      }
      return success;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.logout());
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>(
    (ref) => AuthController(authRepository: ref.read(authRepositoryProvider), hasGroupController: ref.read(hasGroupProvider.notifier)));
