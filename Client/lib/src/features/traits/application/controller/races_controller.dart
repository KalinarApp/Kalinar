import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/races_repository.dart';
import '../../domain/race.dart';
import '../../domain/suggestion_state.dart';
import '../notifier/race_state_notifier.dart';
import '../notifier/races_state_notifier.dart';
import 'traits_controller.dart';

class RacesController implements TraitsController {
  final RacesRepository repo;
  final RacesStateNotifier notifier;
  final RaceStateNotifier race;

  RacesController(this.repo, this.notifier, this.race);

  @override
  Future getById(String id) async {
    race.set(const AsyncLoading());
    race.set(await AsyncValue.guard(() async => await repo.getById(id)));
  }

  @override
  Future<AsyncValue> filter(String? query, {List<SuggestionState>? allowedStates}) async {
    return AsyncValue.guard(() async {
      final abilities = await repo.filter(query: query, allowedStates: allowedStates?.map((e) => e.index.toString()).toList());
      notifier.refresh(abilities);
    });
  }

  Future<List<Race>> search({String? query, List<SuggestionState>? allowedStates}) async {
    final states = allowedStates?.map((e) => e.index.toString()).toList();
    return await repo.filter(query: query, allowedStates: states);
  }

  @override
  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final ability = await repo.createRace(data);
      notifier.add(ability);
    });
  }

  @override
  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final ability = await repo.updateRace(id, data);
      notifier.update(id, ability);
    });
  }

  @override
  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteRace(id);
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

final racesControllerProvider = Provider<RacesController>((ref) {
  return RacesController(
      ref.watch(racesRepositoryProvider), ref.watch(racesStateNotifierProvider.notifier), ref.watch(raceStateNotifierProvider.notifier));
});
