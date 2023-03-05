import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/traits/application/abilities_state_notifier.dart';
import 'package:kalinar/src/features/traits/application/ability_state_notifier.dart';
import 'package:kalinar/src/features/traits/data/abilities_repository.dart';

class AbilitiesController {
  final AbilitiesRepository repo;
  final AbilitiesStateNotifier notifier;
  final AbilityStateNotifier ability;

  AbilitiesController(this.repo, this.notifier, this.ability);

  Future getAbilityById(String id) async {
    ability.set(const AsyncLoading());
    ability.set(await AsyncValue.guard(() async => await repo.getById(id)));
  }

  Future<AsyncValue> filter(String? query) async {
    return AsyncValue.guard(() async {
      final abilities = await repo.filter(query);
      notifier.refresh(abilities);
    });
  }

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final ability = await repo.createAbility(data);
      notifier.add(ability);
    });
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final ability = await repo.updateAbility(id, data);
      notifier.update(id, ability);
    });
  }

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteAbility(id);
    });
  }

  Future<AsyncValue> reject(String id, String reason) async {
    return await AsyncValue.guard(() async {
      await repo.reject(id, reason);
      notifier.reject(id, reason);
    });
  }
}

final abilitiesControllerProvider = Provider<AbilitiesController>((ref) {
  return AbilitiesController(
    ref.watch(abilitiesRepositoryProvider),
    ref.watch(abilitiesStateNotifierProvider.notifier),
    ref.watch(abilityStateNotifierProvider.notifier),
  );
});
