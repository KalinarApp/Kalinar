import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/characters_repository.dart';
import '../notifier/character_overview_state_notifier.dart';

class CharacterOverviewController {
  final CharacterOverviewStateNotifier notifier;
  final CharactersRepository repo;
  final bool isOwner;

  CharacterOverviewController.owner(this.repo, this.notifier) : isOwner = true;
  CharacterOverviewController.foreign(this.repo, this.notifier) : isOwner = false;

  Future<AsyncValue> getAll() async => AsyncValue.guard(() async => notifier.refresh(await repo.getAll(isOwner: isOwner)));

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteCharacter(id);
    });
  }
}

final ownedCharactersProvider = Provider<CharacterOverviewController>((ref) {
  return CharacterOverviewController.owner(ref.watch(charactersRepositoryProvider), ref.watch(ownedCharactersStateProvider.notifier));
});

final foreignCharactersProvider = Provider<CharacterOverviewController>((ref) {
  return CharacterOverviewController.foreign(ref.watch(charactersRepositoryProvider), ref.watch(foreignCharactersStateProvider.notifier));
});
