import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../traits/domain/skill.dart';
import '../data/races_repository.dart';
import '../domain/race.dart';

class RaceListController extends StateNotifier<AsyncValue<List<Race>>> {
  final RacesRepository repo;

  List<Skill> skills = [];

  RaceListController(this.repo) : super(const AsyncLoading());

  Future<void> getAll() async {
    state = const AsyncLoading();
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => repo.getAll());
  }
}

final raceListControllerProvider =
    StateNotifierProvider<RaceListController, AsyncValue<List<Race>>>((ref) => RaceListController(ref.watch(racesRepositoryProvider)));
