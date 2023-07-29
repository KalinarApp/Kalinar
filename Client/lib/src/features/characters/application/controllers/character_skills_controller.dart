import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/characters_repository.dart';
import '../../domain/character_skill.dart';

class CharacterSkillsController extends StateNotifier<AsyncValue<List<CharacterSkill>>> {
  final CharactersRepository repo;

  final String characterId;

  CharacterSkillsController(this.repo, this.characterId) : super(const AsyncValue.loading());

  Future updateFavorite(String skillId, bool isFavorite) async {
    if (!state.hasValue || state.value == null) return;
    final index = state.value!.indexWhere((element) => element.id == skillId);
    final oldState = state.value![index].isFavorite;

    final updatedState = [...state.value!];
    updatedState[index] = updatedState[index].copyWith(isFavorite: isFavorite);
    state = AsyncValue.data(updatedState);

    try {
      await repo.markCharacterSkillAsFavorite(characterId, skillId, isFavorite);
    } catch (_) {
      updatedState[index] = updatedState[index].copyWith(isFavorite: oldState);
      state = AsyncValue.data(updatedState);
    }
  }

  Future getAll() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await repo.listCharacterSkills(characterId, true));
  }
}

final characterSkillsProvider = StateNotifierProvider.family<CharacterSkillsController, AsyncValue<List<CharacterSkill>>, String>((ref, id) {
  return CharacterSkillsController(ref.watch(charactersRepositoryProvider), id);
});
