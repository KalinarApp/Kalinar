import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../../group_management/application/group_notifier.dart';
import '../domain/skill.dart';

class SkillsRepository extends HeroBaseRepository {
  SkillsRepository({super.group});

  Future<Skill> getById(String id) async {
    return await heroGet("/api/skills/$id", (response) => Skill.fromJson(response));
  }

  Future<List<Skill>> filter({String? query, List<int>? allowedStates}) async {
    return await heroGet(
      "/api/skills",
      (response) => List<Skill>.from(response.map((model) => Skill.fromJson(model))),
      query: {"query": query, "allowedStates": allowedStates ?? []},
    );
  }

  Future<Skill> createSkill(Map<String, dynamic> data) async {
    return await heroPost("/api/skills", data, (response) => Skill.fromJson(response));
  }

  Future reject(String id, String reason) async {
    await heroPost("/api/skills/$id/reject", {"reason": reason}, (response) => true);
  }

  Future<Skill> updateSkill(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/skills/$id", data, (response) => Skill.fromJson(response));
  }

  Future<void> deleteSkill(String id) async {
    return await heroDelete("/api/skills/$id");
  }
}

final skillsRepositoryProvider = Provider<SkillsRepository>((ref) => SkillsRepository(group: ref.watch(groupNotifierProvider).group));
