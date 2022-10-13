import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/abilities_repository.dart';
import 'package:hero/src/features/admin/data/skills_repository.dart';

import '../../domain/ability.dart';
import '../../domain/skill.dart';

class CreateSkillController {
  final SkillsRepository skillsRepository;
  final AbilitiesRepository abilitiesRepository;

  CreateSkillController(this.skillsRepository, this.abilitiesRepository);

  Future<List<Ability>> filterAbilities(String query) async {
    return await abilitiesRepository.filter(query);
  }

  Future<Skill?> createSkill(Map<String, dynamic> data) async {
      return await skillsRepository.createSkill(data);
  }
}

final createSkillControllerProvider = Provider<CreateSkillController>((ref) {
  return CreateSkillController(ref.read(skillsRepositoryProvider), ref.read(abilitiesRepositoryProvider));
});
