import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/character_overview.dart';

class CharacterOverviewStateNotifier extends StateNotifier<List<CharacterOverview>?> {
  CharacterOverviewStateNotifier() : super(null);

  void refresh(List<CharacterOverview>? list) {
    state = list?..sortBy((element) => element.name);
  }

  void add(CharacterOverview character) {
    refresh([...state ?? [], character]);
  }

  void remove(String id) {
    state = state?.whereNot((element) => element.id == id).toList();
  }
}

final charactersStateProvider = StateNotifierProvider<CharacterOverviewStateNotifier, List<CharacterOverview>?>((ref) {
  return CharacterOverviewStateNotifier();
});

final ownedCharactersStateProvider = StateNotifierProvider<CharacterOverviewStateNotifier, List<CharacterOverview>?>((ref) {
  return CharacterOverviewStateNotifier();
});

final foreignCharactersStateProvider = StateNotifierProvider<CharacterOverviewStateNotifier, List<CharacterOverview>?>((ref) {
  return CharacterOverviewStateNotifier();
});
