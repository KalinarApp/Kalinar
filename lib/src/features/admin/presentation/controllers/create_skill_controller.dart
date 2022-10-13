import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/abilities_repository.dart';
import 'package:hero/src/features/admin/data/imgur_repository.dart';
import 'package:hero/src/features/admin/data/skills_repository.dart';

import '../../domain/ability.dart';
import '../../domain/skill.dart';

class CreateSkillController {
  final SkillsRepository skillsRepository;
  final AbilitiesRepository abilitiesRepository;
  final ImgurRepository imgurRepository;

  CreateSkillController(this.skillsRepository, this.abilitiesRepository, this.imgurRepository);

  Future<List<Ability>> filterAbilities(String query) async {
    return await abilitiesRepository.filter(query);
  }

  Future<String?> uploadImage(String base64) async {
    return await imgurRepository.uploadImageToImgur(base64);
  }

  Future<Skill?> createSkill(Map<String, dynamic> data) async {
    return await skillsRepository.createSkill(data);
  }
}

final createSkillControllerProvider = Provider<CreateSkillController>((ref) {
  return CreateSkillController(ref.read(skillsRepositoryProvider), ref.read(abilitiesRepositoryProvider), ref.read(imgurRepositoryProvider));
});
