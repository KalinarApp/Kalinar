import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../traits/data/skills_repository.dart';
import '../../../traits/domain/skill.dart';
import 'skill_list_controller.dart';

class SkillController {
  final SkillsRepository repo;

  final SkillListController skillList;

  SkillController(this.repo, this.skillList);

  Future<AsyncValue<Skill>> create(Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.createSkill(data));
    await skillList.getAllSkills();
    return state;
  }

  Future<AsyncValue<Skill>> update(String id, Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.updateSkill(id, data));
    await skillList.getAllSkills();
    return state;
  }

  Future<AsyncValue> deleteSkill(String id) async {
    final state = await AsyncValue.guard(() async => await repo.deleteSkill(id));
    await skillList.getAllSkills();
    return state;
  }
}

final skillControllerProvider =
    Provider<SkillController>((ref) => SkillController(ref.watch(skillsRepositoryProvider), ref.watch(skillListControllerProvider.notifier)));
