import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../characters/data/characters_repository.dart';
import '../../../characters/domain/character_overview.dart';
import '../../skilltrees/data/skilltrees_repository.dart';

class CharactersController extends StateNotifier<AsyncValue<List<CharacterOverview>>> {
  CharactersRepository charactersRepository;
  SkilltreesRepository skilltreesRepository;

  CharactersController(this.charactersRepository, this.skilltreesRepository) : super(const AsyncLoading());

  Future getAll() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async => await charactersRepository.getAllExtended());
  }

  Future<AsyncValue> update(String skilltreeId, int points) async {
    return await AsyncValue.guard(() async => await skilltreesRepository.updateSkillpoints(skilltreeId, points));
  }
}

final charactersProvider = StateNotifierProvider<CharactersController, AsyncValue<List<CharacterOverview>>>((ref) {
  return CharactersController(ref.watch(charactersRepositoryProvider), ref.watch(skilltreesRepositoryProvider));
});
