import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/character_overview.dart';

class OrderedCharacterOverviewStateNotifier extends StateNotifier<List<CharacterOverview>> {
  OrderedCharacterOverviewStateNotifier() : super([]);

  void load(List<CharacterOverview>? list) {
    state = (list?..sortBy((element) => element.name)) ?? [];
  }

  Future reorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final character = state[oldIndex];
    state = [...state.where((element) => element != character).toList()..insert(newIndex, character)];

    // final prefs = await SharedPreferences.getInstance();
    // prefs.setStringList("PreferedCharacterOrder", state.map((e) => e.id).toList());
  }
}

final orderedCharactersStateProvider = StateNotifierProvider<OrderedCharacterOverviewStateNotifier, List<CharacterOverview>>((ref) {
  return OrderedCharacterOverviewStateNotifier();
});
