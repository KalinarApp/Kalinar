import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../skilling/data/abilities_repository.dart';
import '../../../skilling/domain/ability.dart';

class AbilitiesController extends StateNotifier<AsyncValue<List<Ability>>> {
  final AbilitiesRepository repo;

  List<Ability> abilities = [];

  AbilitiesController(this.repo) : super(const AsyncLoading());

  Future<void> getAllAbilities() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      abilities = await repo.getAll();
      return abilities;
    });
  }

  Future<void> createAbility(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final ability = await repo.createAbility(data);
      return [...abilities, ability];
    });
  }

  Future<void> deleteAbility(String name) async {
    state = await AsyncValue.guard(() async {
      if (await repo.deleteAbility(name)) {
        abilities.removeWhere((element) => element.name == name);
      }

      return abilities;
    });
  }
}

final abilitiesControllerProvider =
    StateNotifierProvider<AbilitiesController, AsyncValue<List<Ability>>>((ref) => AbilitiesController(ref.read(abilitiesRepositoryProvider)));
