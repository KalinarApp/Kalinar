import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/abilities_repository.dart';
import '../../domain/ability.dart';
import 'ability_list_controller.dart';

class AbilityController {
  final AbilitiesRepository repo;
  final AbilityListController abilityList;

  AbilityController(this.repo, this.abilityList);

  Future<AsyncValue<Ability>> get(String name) async {
    return await AsyncValue.guard(() async => repo.getByName(name));
  }

  Future<AsyncValue<Ability>> create(Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.createAbility(data));
    await abilityList.getAllAbilities();
    return state;

    // Ability? ability;
    // state = const AsyncLoading();
    // state = await AsyncValue.guard(() async {
    //   ability = await repo.createAbility(data);
    //   return [...abilities, ability!];
    // });
    // return ability;
  }

  Future<AsyncValue<Ability>> update(String name, Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.updateAbility(name, data));
    await abilityList.getAllAbilities();
    return state;

    // Ability? ability;
    // state = const AsyncLoading();
    // state = await AsyncValue.guard(() async {
    //   final index = abilities.indexWhere((element) => element.name == name);
    //   ability = await repo.updateAbility(name, data);
    //   abilities[index] = ability!;
    //   return abilities;
    // });

    // return ability;
  }

  Future<AsyncValue<bool>> deleteAbility(String name) async {
    final state = await AsyncValue.guard(() async => await repo.deleteAbility(name));
    await abilityList.getAllAbilities();
    return state;

    // state = const AsyncLoading();
    // state = await AsyncValue.guard(() async {
    //   if (await repo.deleteAbility(name)) {
    //     abilities = [...abilities.where((element) => element.name != name)];
    //   }
    //   return abilities;
    // });
  }
}

final abilityControllerProvider =
    Provider<AbilityController>((ref) => AbilityController(ref.read(abilitiesRepositoryProvider), ref.read(abilityListControllerProvider.notifier)));
