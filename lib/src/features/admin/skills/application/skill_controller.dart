import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/imgur_repository.dart';
import '../data/skills_repository.dart';
import '../domain/skill.dart';
import 'skill_list_controller.dart';

class SkillController {
  final SkillsRepository repo;
  final ImgurRepository imgurRepository;

  final SkillListController skillList;

  SkillController(this.repo, this.imgurRepository, this.skillList);

  Future<String?> _uploadImage(String base64) async {
    return await imgurRepository.uploadImageToImgur(base64);
  }

  Future<AsyncValue<Skill>> create(Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async {
      Map<String, dynamic> map = {};
      map.addAll(data);

      final iconUrl = await _uploadImage(map["iconUrl"]);
      map.update("iconUrl", (_) => iconUrl);
      return await repo.createSkill(map);
    });

    await skillList.getAllSkills();
    return state;
  }

  Future<AsyncValue<Skill>> update(String id, Map<String, dynamic> data) async {
    final state = await AsyncValue.guard(() async => await repo.updateSkill(id, data));
    await skillList.getAllSkills();
    return state;
  }

  Future<AsyncValue<bool>> deleteSkill(String id) async {
    final state = await AsyncValue.guard(() async => await repo.deleteSkill(id));
    await skillList.getAllSkills();
    return state;
  }
}

final skillControllerProvider = Provider<SkillController>(
    (ref) => SkillController(ref.read(skillsRepositoryProvider), ref.read(imgurRepositoryProvider), ref.read(skillListControllerProvider.notifier)));
