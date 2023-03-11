import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/skill.dart';

class SkillStateNotifier extends StateNotifier<AsyncValue<Skill>> {
  SkillStateNotifier() : super(const AsyncLoading());

  void set(AsyncValue<Skill> value) {
    state = value;
  }
}

final skillStateNotifierProvider = StateNotifierProvider<SkillStateNotifier, AsyncValue<Skill>>((ref) {
  return SkillStateNotifier();
});
