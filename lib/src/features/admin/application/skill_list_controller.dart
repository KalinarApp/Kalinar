import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/domain/skill.dart';

import '../data/skills_repository.dart';

class SkillListController extends StateNotifier<AsyncValue<List<Skill>>> {
  final SkillsRepository repo;

  List<Skill> skills = [];

  SkillListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllSkills() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      skills = await repo.getAll();
      return skills;
    });
  }

  Future<List<Skill>> filter(String query) async {
    return await repo.getAll();
  }
}

final skillListControllerProvider =
    StateNotifierProvider<SkillListController, AsyncValue<List<Skill>>>((ref) => SkillListController(ref.read(skillsRepositoryProvider)));
