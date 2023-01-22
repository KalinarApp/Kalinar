import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/characters_repository.dart';
import '../domain/character.dart';
import '../domain/character_overview.dart';

import 'character_list_controller.dart';

class CharacterController extends StateNotifier<AsyncValue<Character>> {
  final CharactersRepository repo;

  final CharacterListController characterList;

  CharacterController(this.repo, this.characterList) : super(const AsyncLoading());

  Future refresh(String id) async {
    state = await AsyncValue.guard(() async => await repo.getById(id));
  }

  Future getById(String id) async {
    state = const AsyncLoading();
    await refresh(id);
  }

  Future<List<CharacterOverview>> getAll() async {
    return await repo.getAll();
  }

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.createCharacter(data);
      characterList.refresh();
    });
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.updateCharacter(id, data);
      characterList.refresh();
      refresh(id);
    });
  }

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      await repo.deleteCharacter(id);
      characterList.refresh();
    });
  }
}

final characterControllerProvider = StateNotifierProvider<CharacterController, AsyncValue<Character>>(
    (ref) => CharacterController(ref.watch(charactersRepositoryProvider), ref.watch(characterListControllerProvider.notifier)));
