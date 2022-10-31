import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/base_repository.dart';
import 'package:hero/src/features/admin/domain/skill.dart';

import '../../authentication/data/auth_repository.dart';

class SkillsRepository extends HeroBaseRepository {
  SkillsRepository(super.client);

  Future<List<Skill>> getAll() async {
    return await heroGet("/api/skills", (response) => List<Skill>.from(response.map((model) => Skill.fromJson(model))));
  }

  Future<Skill> createSkill(Map<String, dynamic> data) async {
    return heroPost("/api/skills", data, (response) => Skill.fromJson(json.decode(response)));
  }

  Future<Skill> updateSkill(String id, Map<String, dynamic> data) async {
    return heroUpdate("/api/skills/$id", data, (response) => Skill.fromJson(json.decode(response)));
  }

  Future<bool> deleteSkill(String id) async {
    return heroDelete("/api/skills/$id");
  }
}

final skillsRepositoryProvider = Provider<SkillsRepository>((ref) => SkillsRepository(ref.read(authProvider)));
