import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/characters_repository.dart';
import '../../domain/character_overview.dart';
import '../notifier/character_overview_state_notifier.dart';
import '../notifier/character_state_notifier.dart';

class CharacterController {
  final CharactersRepository repo;

  final CharacterOverviewStateNotifier notifier;
  final CharacterStateNotifier character;

  CharacterController(this.repo, this.notifier, this.character);

  Future<AsyncValue> get(String id) async {
    return await AsyncValue.guard(() async => character.refresh(await repo.getById(id)));
  }

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final character = await repo.createCharacter(data);
      notifier.add(character);
    });
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final result = await repo.updateCharacter(id, data);
      character.refresh(result);
    });
  }

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteCharacter(id);
    });
  }

  Future<List<CharacterOverview>> getAll() {
    return repo.getAll();
  }
}

final characterControllerProvider = Provider<CharacterController>((ref) => CharacterController(
      ref.watch(charactersRepositoryProvider),
      ref.watch(ownedCharactersStateProvider.notifier),
      ref.watch(characterStateProvider.notifier),
    ));
