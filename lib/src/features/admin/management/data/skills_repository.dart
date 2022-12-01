import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/base_repository.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../group_management/application/group_notifier.dart';
import '../domain/skill.dart';

class SkillsRepository extends HeroBaseRepository {
  SkillsRepository(super.client, {super.group});

  Future<List<Skill>> getAll() async {
    return await heroGet("/api/skills", (response) => List<Skill>.from(response.map((model) => Skill.fromJson(model))));
  }

  Future<Skill> createSkill(Map<String, dynamic> data) async {
    return await heroPost("/api/skills", data, (response) => Skill.fromJson(response));
  }

  Future<Skill> updateSkill(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/skills/$id", data, (response) => Skill.fromJson(response));
  }

  Future<void> deleteSkill(String id) async {
    return await heroDelete("/api/skills/$id");
  }
}

final skillsRepositoryProvider =
    Provider<SkillsRepository>((ref) => SkillsRepository(ref.watch(authProvider), group: ref.watch(groupNotifierProvider).group));
