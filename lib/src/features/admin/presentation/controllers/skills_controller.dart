import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/domain/skill.dart';

import '../../data/skills_repository.dart';

class SkillsController extends StateNotifier<AsyncValue<List<Skill>>> {
  final SkillsRepository repo;

  List<Skill> skills = [];

  SkillsController(this.repo) : super(const AsyncLoading());

  Future<void> getAllSkills() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      skills = await repo.getAll();
      return skills;
    });
  }

  Future<void> createSkill(Skill skill) async {
    state = AsyncData([...skills, skill]);
  }

  Future<void> deleteSkill(String id) async {
    state = await AsyncValue.guard(() async {
      if (await repo.deleteSkill(id)) {
        skills = [...skills.where((element) => element.id != id)];
      }
      return skills;
    });
  }
}

final skillsControllerProvider =
    StateNotifierProvider<SkillsController, AsyncValue<List<Skill>>>((ref) => SkillsController(ref.read(skillsRepositoryProvider)));
