import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../admin/skilltrees/data/skilltrees_repository.dart';
import '../../admin/skilltrees/domain/skillpoints.dart';

class SkillpointController extends StateNotifier<Skillpoints> {
  final SkilltreesRepository repo;
  SkillpointController(this.repo) : super(const Skillpoints());

  Future<void> getSkillpointsForSkilltree(String id) async {
    try {
      state = await repo.getSkillpoints(id);
    } catch (ex, stackTrace) {
      Sentry.captureException(ex, stackTrace: stackTrace);
    }
  }
}

final skillpointControllerProvider = StateNotifierProvider.autoDispose<SkillpointController, Skillpoints>((ref) {
  return SkillpointController(ref.watch(skilltreesRepositoryProvider));
});
