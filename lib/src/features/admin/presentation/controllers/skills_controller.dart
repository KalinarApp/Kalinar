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

  Future<Skill?> createSkill(Map<String, dynamic> data) async {
    Skill? skill;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      skill = await repo.createSkill(data);
      return [...skills, skill!];
    });
    return skill;
  }

  Future<void> deleteSkill(String name) async {
    state = await AsyncValue.guard(() async {
      if (await repo.deleteSkill(name)) {
        skills = [...skills.where((element) => element.name != name)];
      }
      return skills;
    });
  }
}

final skillControllerProvider =
    StateNotifierProvider<SkillsController, AsyncValue<List<Skill>>>((ref) => SkillsController(ref.read(skillsRepositoryProvider)));
