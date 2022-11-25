import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/characters_repository.dart';
import '../domain/character.dart';
import '../domain/character_overview.dart';

class CharacterListController extends StateNotifier<AsyncValue<List<CharacterOverview>>> {
  final CharactersRepository repo;

  CharacterListController(this.repo) : super(const AsyncLoading());

  Future<void> getAll() async {
    state = const AsyncLoading();
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async => repo.getAll());
  }
}

final characterListControllerProvider = StateNotifierProvider<CharacterListController, AsyncValue<List<CharacterOverview>>>(
    (ref) => CharacterListController(ref.read(charactersRepositoryProvider)));
