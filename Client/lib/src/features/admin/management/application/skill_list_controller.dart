import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../traits/data/skills_repository.dart';
import '../../../traits/domain/skill.dart';

class SkillListController extends StateNotifier<AsyncValue<List<Skill>>> {
  final SkillsRepository repo;

  List<Skill> skills = [];

  SkillListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllSkills() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      skills = await repo.filter();
      return skills;
    });
  }

  Future<List<Skill>> filter(String query) async {
    return await repo.filter();
  }
}

final skillListControllerProvider =
    StateNotifierProvider<SkillListController, AsyncValue<List<Skill>>>((ref) => SkillListController(ref.watch(skillsRepositoryProvider)));
