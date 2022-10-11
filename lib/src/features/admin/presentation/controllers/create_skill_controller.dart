import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/abilities_repository.dart';
import 'package:hero/src/features/admin/data/skills_repository.dart';
import 'package:hero/src/features/admin/domain/create_skill_state.dart';

import '../../domain/ability.dart';

class CreateSkillController extends StateNotifier<CreateSkillState> {
  final SkillsRepository skillsRepository;
  final AbilitiesRepository abilitiesRepository;

  CreateSkillController(this.skillsRepository, this.abilitiesRepository) : super(const CreateSkillState());

  Future<List<Ability>> filterAbilities(String query) async {
    return await abilitiesRepository.filter(query);
  }
}

final createSkillControllerProvider = StateNotifierProvider<CreateSkillController, CreateSkillState>((ref) {
  return CreateSkillController(ref.read(skillsRepositoryProvider), ref.read(abilitiesRepositoryProvider));
});
