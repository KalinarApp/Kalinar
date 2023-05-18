import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/characters_repository.dart';
import '../notifier/character_overview_state_notifier.dart';

class CharacterOverviewController {
  final CharacterOverviewStateNotifier notifier;
  final CharactersRepository repo;
  final bool? isOwner;

  CharacterOverviewController(this.repo, this.notifier, this.isOwner);

  Future<AsyncValue> getAll() async => AsyncValue.guard(() async => notifier.refresh(await repo.getAll(isOwner: isOwner)));

  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteCharacter(id);
    });
  }
}

final charactersProvider = Provider<CharacterOverviewController>((ref) {
  return CharacterOverviewController(ref.watch(charactersRepositoryProvider), ref.watch(charactersStateProvider.notifier), null);
});

final ownedCharactersProvider = Provider<CharacterOverviewController>((ref) {
  return CharacterOverviewController(ref.watch(charactersRepositoryProvider), ref.watch(ownedCharactersStateProvider.notifier), true);
});

final foreignCharactersProvider = Provider<CharacterOverviewController>((ref) {
  return CharacterOverviewController(ref.watch(charactersRepositoryProvider), ref.watch(foreignCharactersStateProvider.notifier), false);
});
