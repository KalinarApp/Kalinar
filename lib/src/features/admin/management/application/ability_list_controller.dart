import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/abilities_repository.dart';
import '../domain/ability.dart';

class AbilityListController extends StateNotifier<AsyncValue<List<Ability>>> {
  final AbilitiesRepository repo;

  AbilityListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllAbilities() async {
    state = const AsyncLoading();
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async => repo.getAll());
  }

  Future<List<Ability>> filter(String query) async {
    final list = await repo.filter(query);
    return list;
  }
}

final abilityListControllerProvider =
    StateNotifierProvider<AbilityListController, AsyncValue<List<Ability>>>((ref) => AbilityListController(ref.read(abilitiesRepositoryProvider)));
