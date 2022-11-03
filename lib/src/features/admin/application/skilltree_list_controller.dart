import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'states/skilltree_overview_state.dart';
import '../data/skilltrees_repository.dart';
import '../domain/skilltree_overview.dart';

class SkilltreeListController extends StateNotifier<AsyncValue<SkilltreeOverviewState>> {
  final SkilltreesRepository repo;

  SkilltreeListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllSkilltrees() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final overviews = await repo.getAll();
      var skilltreeOverviewState = SkilltreeOverviewState(unassigned: overviews.unassigned(), characters: overviews.groupByCharacters());
      return skilltreeOverviewState;
    });
  }
}

final skilltreeListControllerProvider = StateNotifierProvider<SkilltreeListController, AsyncValue<SkilltreeOverviewState>>(
    (ref) => SkilltreeListController(ref.read(skilltreesRepositoryProvider)));
