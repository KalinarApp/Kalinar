import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/domain/skill.dart';

import '../../data/imgur_repository.dart';
import '../../data/skills_repository.dart';

class SkillsController extends StateNotifier<AsyncValue<List<Skill>>> {
  final SkillsRepository repo;
  final ImgurRepository imgurRepository;

  List<Skill> skills = [];

  SkillsController(this.repo, this.imgurRepository) : super(const AsyncLoading());

  Future<String?> _uploadImage(String base64) async {
    return await imgurRepository.uploadImageToImgur(base64);
  }

  Future<void> getAllSkills() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      skills = await repo.getAll();
      return skills;
    });
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

    Skill skill = await repo.createSkill(map);
    state = AsyncData([...skills, skill]);

    return skill;
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

final skillsControllerProvider = StateNotifierProvider<SkillsController, AsyncValue<List<Skill>>>(
    (ref) => SkillsController(ref.read(skillsRepositoryProvider), ref.read(imgurRepositoryProvider)));
