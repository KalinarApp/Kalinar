import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/abilities_repository.dart';
import 'package:hero/src/features/admin/data/imgur_repository.dart';
import 'package:hero/src/features/admin/data/skills_repository.dart';
import 'package:hero/src/features/admin/presentation/controllers/skills_controller.dart';

import '../../domain/ability.dart';
import '../../domain/skill.dart';

class CreateSkillController {
  final SkillsRepository skillsRepository;
  final AbilitiesRepository abilitiesRepository;
  final ImgurRepository imgurRepository;

  final SkillsController skillsController;

  CreateSkillController(this.skillsRepository, this.abilitiesRepository, this.imgurRepository, this.skillsController);

  Future<String?> _uploadImage(String base64) async {
    return await imgurRepository.uploadImageToImgur(base64);
  }

  Future<List<Ability>> filterAbilities(String query) async {
    return await abilitiesRepository.filter(query);
  }

  Future<Skill?> createSkill(Map<String, dynamic> data) async {
    Map<String, dynamic> map = {};
    map.addAll(data);
    final List<dynamic> icon = map.remove("icon");
    if (icon.isNotEmpty) {
      final url = await _uploadImage(icon[0]);
      if (null != url) {
        map.putIfAbsent("iconUrl", () => url);
      }
    }

    map.putIfAbsent("id", () => "");

    Skill skill = await skillsRepository.createSkill(map);
    skillsController.createSkill(skill);

    return skill;
  }
}

final createSkillControllerProvider = Provider<CreateSkillController>((ref) {
  return CreateSkillController(ref.read(skillsRepositoryProvider), ref.read(abilitiesRepositoryProvider), ref.read(imgurRepositoryProvider),
      ref.read(skillsControllerProvider.notifier));
});
