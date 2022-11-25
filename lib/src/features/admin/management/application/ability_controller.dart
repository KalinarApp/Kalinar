import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/abilities_repository.dart';
import '../domain/ability.dart';

import 'ability_list_controller.dart';

class AbilityController {
  final AbilitiesRepository repo;
  final AbilityListController abilityList;

  AbilityController(this.repo, this.abilityList);

  Future<AsyncValue<Ability>> get(String id) async {
    return await AsyncValue.guard(() async => repo.getByName(id));
  }

  Future<AsyncValue<Ability>> create(Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.createAbility(data));
    await abilityList.refresh();
    return state;
  }

  Future<AsyncValue<Ability>> update(String id, Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.updateAbility(id, data));
    await abilityList.refresh();
    return state;
  }

  Future<AsyncValue<bool>> deleteAbility(String id) async {
    final state = await AsyncValue.guard(() async => await repo.deleteAbility(id));
    await abilityList.refresh();
    return state;
  }
}

final abilityControllerProvider =
    Provider<AbilityController>((ref) => AbilityController(ref.read(abilitiesRepositoryProvider), ref.read(abilityListControllerProvider.notifier)));
