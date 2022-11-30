import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/blueprint_repository.dart';
import '../domain/blueprint_overview.dart';

class BlueprintListController extends StateNotifier<AsyncValue<List<BlueprintOverview>>> {
  final BlueprintRepository repo;

  BlueprintListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllBlueprints() async {
    state = const AsyncLoading();
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async => await repo.getAll());
  }
}

final blueprintListControllerProvider = StateNotifierProvider<BlueprintListController, AsyncValue<List<BlueprintOverview>>>(
    (ref) => BlueprintListController(ref.watch(blueprintRepositoryProvider)));
