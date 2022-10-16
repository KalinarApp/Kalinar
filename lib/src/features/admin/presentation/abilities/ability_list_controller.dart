import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/abilities_repository.dart';

import '../../domain/ability.dart';

class AbilityListController extends StateNotifier<AsyncValue<List<Ability>>> {
  final AbilitiesRepository repo;

  AbilityListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllAbilities() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => repo.getAll());
  }

  Future<List<Ability>> filter(String query) async {
    return await repo.filter(query);
  }
}

final abilityListControllerProvider =
    StateNotifierProvider<AbilityListController, AsyncValue<List<Ability>>>((ref) => AbilityListController(ref.read(abilitiesRepositoryProvider)));
