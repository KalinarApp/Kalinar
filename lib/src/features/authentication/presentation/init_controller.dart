import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/hero_api.dart';

class InitController extends StateNotifier<AsyncValue<void>> {
  final FlutterAuth authRepository;

  InitController({required this.authRepository}) : super(const AsyncData(null));

  Future<void> initialize() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.init);
  }
}

final initControllerProvider =
    StateNotifierProvider.autoDispose<InitController, AsyncValue<void>>((ref) => InitController(authRepository: ref.watch(authProvider)));
