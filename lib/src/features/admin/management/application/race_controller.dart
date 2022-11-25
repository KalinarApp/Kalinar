import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/races_repository.dart';
import '../domain/race.dart';

import 'race_list_controller.dart';

class RaceController {
  final RacesRepository repo;

  final RaceListController raceList;

  RaceController(this.repo, this.raceList);

  // Future<Race> getById(String id) async {
  //   return await repo.getById(id);
  // }

  Future<List<Race>> getAll() async {
    return await repo.getAll();
  }

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.createRace(data);
      raceList.refresh();
    });
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.updateRace(id, data);
      raceList.refresh();
    });
  }

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      await repo.deleteRace(id);
      raceList.refresh();
    });
  }
}

final raceControllerProvider =
    Provider<RaceController>((ref) => RaceController(ref.read(racesRepositoryProvider), ref.read(raceListControllerProvider.notifier)));
