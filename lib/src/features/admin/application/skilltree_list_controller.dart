import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/skilltrees_repository.dart';
import 'package:hero/src/features/admin/domain/skill.dart';
import 'package:hero/src/features/admin/domain/skilltree_overview.dart';

import '../data/skills_repository.dart';

class SkilltreeListController extends StateNotifier<AsyncValue<List<SkilltreeOverview>>> {
  final SkilltreesRepository repo;

  List<SkilltreeOverview> skills = [];

  SkilltreeListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllSkilltrees() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      skills = await repo.getAll();
      return skills;
    });
  }

  
}

final skillListControllerProvider = StateNotifierProvider<SkilltreeListController, AsyncValue<List<SkilltreeOverview>>>(
    (ref) => SkilltreeListController(ref.read(skilltreesRepositoryProvider)));
