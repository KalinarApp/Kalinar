import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/skills_repository.dart';
import '../../domain/skill.dart';
import '../../domain/suggestion_state.dart';
import '../notifier/skill_state_notifier.dart';
import '../notifier/skills_state_notifier.dart';
import 'traits_controller.dart';

class SkillsController implements TraitsController {
  final SkillsRepository repo;
  final SkillsStateNotifier notifier;
  final SkillStateNotifier skill;

  SkillsController(this.repo, this.notifier, this.skill);

  @override
  Future getById(String id) async {
    skill.set(const AsyncLoading());
    skill.set(await AsyncValue.guard(() async => await repo.getById(id)));
  }

  @override
  Future<AsyncValue> filter(String? query, {List<SuggestionState>? allowedStates}) async {
    return AsyncValue.guard(() async {
      final skills = await repo.filter(query: query, allowedStates: allowedStates?.map((e) => e.index.toString()).toList());
      notifier.refresh(skills);
    });
  }

  Future<List<Skill>> search({String? query, List<SuggestionState>? allowedStates}) async {
    final states = allowedStates?.map((e) => e.index.toString()).toList();
    return await repo.filter(query: query, allowedStates: states);
  }

  @override
  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final skill = await repo.createSkill(data);
      notifier.add(skill);
    });
  }

  @override
  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final skill = await repo.updateSkill(id, data);
      notifier.update(id, skill);
    });
  }

  @override
  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteSkill(id);
    });
  }

  @override
  Future<AsyncValue> reject(String id, String reason) async {
    return await AsyncValue.guard(() async {
      await repo.reject(id, reason);
      notifier.reject(id, reason);
    });
  }
}

final skillsControllerProvider = Provider<SkillsController>((ref) {
  return SkillsController(
      ref.watch(skillsRepositoryProvider), ref.watch(skillsStateNotifierProvider.notifier), ref.watch(skillStateNotifierProvider.notifier));
});
