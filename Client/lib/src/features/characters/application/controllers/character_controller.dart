import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/characters/domain/character_overview.dart';

import '../../data/characters_repository.dart';
import '../notifier/character_overview_state_notifier.dart';
import '../notifier/character_state_notifier.dart';

class CharacterController {
  final CharactersRepository repo;

  final CharacterOverviewStateNotifier ownedNotifier;
  final CharacterOverviewStateNotifier allNotifier;

  final CharacterStateNotifier character;

  CharacterController(this.repo, this.ownedNotifier, this.allNotifier, this.character);

  Future<AsyncValue> get(String id) async {
    return await AsyncValue.guard(() async => character.refresh(await repo.getById(id)));
  }

  Future<AsyncValue<String>> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final character = await repo.createCharacter(data);
      ownedNotifier.add(character);
      allNotifier.add(character);
      return character.id;
    });
  }

  Future<AsyncValue<String>> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final result = await repo.updateCharacter(id, data);
      character.refresh(result);
      return result.id;
    });
  }

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      ownedNotifier.remove(id);
      allNotifier.remove(id);
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
      ref.watch(charactersStateProvider.notifier),
      ref.watch(characterStateProvider.notifier),
    ));
