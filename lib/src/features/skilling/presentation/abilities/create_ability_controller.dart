import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/skilling/domain/ability.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../data/abilities_repository.dart';

class CreateAbilityController extends StateNotifier<AsyncValue<Ability>> {
  final AbilitiesRepository repo;
  final buttonController = RoundedLoadingButtonController();

  CreateAbilityController(this.repo) : super(const AsyncLoading());

  Future<void> create(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.createAbility(data));
  }

  Future<void> update(String name, Map<String, dynamic> data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.updateAbility(name, data));
  }

  void reset() {
    buttonController.reset();
  }
}

final createAbilityControllerProvider = StateNotifierProvider.autoDispose<CreateAbilityController, AsyncValue<Ability?>>(
    (ref) => CreateAbilityController(ref.read(abilitiesRepositoryProvider)));
