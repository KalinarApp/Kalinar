import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/traits/application/controller/traits_controller.dart';
import 'package:kalinar/src/features/traits/application/notifier/abilities_state_notifier.dart';
import 'package:kalinar/src/features/traits/application/notifier/ability_state_notifier.dart';
import 'package:kalinar/src/features/traits/data/abilities_repository.dart';
import 'package:kalinar/src/features/traits/domain/suggestion_state.dart';

import '../../domain/ability.dart';

class AbilitiesController implements TraitsController {
  final AbilitiesRepository repo;
  final AbilitiesStateNotifier notifier;
  final AbilityStateNotifier ability;

  AbilitiesController(this.repo, this.notifier, this.ability);

  @override
  Future getById(String id) async {
    ability.set(const AsyncLoading());
    ability.set(await AsyncValue.guard(() async => await repo.getById(id)));
  }

  @override
  Future<AsyncValue> filter(String? query, {List<SuggestionState>? allowedStates}) async {
    return AsyncValue.guard(() async {
      final abilities = await repo.filter(query: query, allowedStates: allowedStates?.map((e) => e.index.toString()).toList());
      notifier.refresh(abilities);
    });
  }

  Future<List<Ability>> search({String? query, List<SuggestionState>? allowedStates}) async {
    final states = allowedStates?.map((e) => e.index.toString()).toList();
    return await repo.filter(query: query, allowedStates: states);
  }

  @override
  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final ability = await repo.createAbility(data);
      notifier.add(ability);
    });
  }

  @override
  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final ability = await repo.updateAbility(id, data);
      notifier.update(id, ability);
    });
  }

  @override
  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteAbility(id);
    });
  }

  @override
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
