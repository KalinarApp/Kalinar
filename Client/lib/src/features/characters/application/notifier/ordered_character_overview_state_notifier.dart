import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/character_overview.dart';

class OrderedCharacterOverviewStateNotifier extends StateNotifier<List<CharacterOverview>> {
  static const String preferedCharacterOrderKey = "PreferedCharacterOrder";

  OrderedCharacterOverviewStateNotifier() : super([]);

  Future load(List<CharacterOverview>? list) async {
    final prefs = await SharedPreferences.getInstance();
    final orderedIds = prefs.getStringList(preferedCharacterOrderKey);

    if (orderedIds != null && list != null) {
      final orderedItems = list.where((element) => orderedIds.contains(element.id)).toList();
      final newItems = list.where((element) => !orderedIds.contains(element.id)).toList();

      orderedItems.sort((a, b) => orderedIds.indexOf(a.id).compareTo(orderedIds.indexOf(b.id)));
      orderedItems.addAll(newItems..sortBy((element) => element.name));

      if (newItems.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setStringList(preferedCharacterOrderKey, orderedItems.map((e) => e.id).toList());
      }
      state = orderedItems;
    } else {
      state = (list?..sortBy((element) => element.name)) ?? [];
    }
  }

  Future reorder(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex -= 1;
    final character = state[oldIndex];
    state = [...state.where((element) => element != character).toList()..insert(newIndex, character)];

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(preferedCharacterOrderKey, state.map((e) => e.id).toList());
  }
}

final orderedCharactersStateProvider = StateNotifierProvider<OrderedCharacterOverviewStateNotifier, List<CharacterOverview>>((ref) {
  return OrderedCharacterOverviewStateNotifier();
});
