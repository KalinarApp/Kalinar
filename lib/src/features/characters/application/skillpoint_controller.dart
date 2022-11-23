import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/skilltrees/data/skilltrees_repository.dart';
import 'package:hero/src/features/admin/skilltrees/domain/skillpoints.dart';

class SkillpointController extends StateNotifier<Skillpoints> {
  final SkilltreesRepository repo;
  late Timer timer;

  SkillpointController(this.repo) : super(const Skillpoints());

  Future<void> getSkillpointsForSkilltree(String id) async {
    timer = Timer.periodic(const Duration(seconds: 30), (_) async {
      try {
        state = await repo.getSkillpoints(id);
      } catch (error) {}
    });
  }
}

final skillpointControllerProvider = StateNotifierProvider.autoDispose<SkillpointController, Skillpoints>((ref) {
  return SkillpointController(ref.read(skilltreesRepositoryProvider));
});
