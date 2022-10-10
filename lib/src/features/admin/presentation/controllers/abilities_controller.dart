import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/abilities_repository.dart';
import '../../domain/ability.dart';

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

  Future<Ability?> createAbility(Map<String, dynamic> data) async {
    Ability? ability;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      ability = await repo.createAbility(data);
      return [...abilities, ability!];
    });
    return ability;
  }

  Future<void> deleteAbility(String name) async {
    state = await AsyncValue.guard(() async {
      if (await repo.deleteAbility(name)) {
        abilities = [...abilities.where((element) => element.name != name)];
      }
      return abilities;
    });
  }
}

final abilitiesControllerProvider =
    StateNotifierProvider<AbilitiesController, AsyncValue<List<Ability>>>((ref) => AbilitiesController(ref.read(abilitiesRepositoryProvider)));
