import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/character_overview.dart';

import '../data/characters_repository.dart';
import '../domain/character.dart';
import 'character_list_controller.dart';

class CharacterController {
  final CharactersRepository repo;

  final CharacterListController characterList;

  CharacterController(this.repo, this.characterList);

  Future<Character> getById(String id) async {
    return await repo.getById(id);
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
    });
  }

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      await repo.deleteCharacter(id);
      characterList.refresh();
    });
  }
}

final characterControllerProvider = Provider<CharacterController>(
    (ref) => CharacterController(ref.read(charactersRepositoryProvider), ref.read(characterListControllerProvider.notifier)));
