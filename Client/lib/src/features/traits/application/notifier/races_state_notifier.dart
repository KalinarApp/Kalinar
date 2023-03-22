import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/race.dart';
import '../../domain/suggestion_state.dart';

class RacesStateNotifier extends StateNotifier<List<Race>?> {
  RacesStateNotifier() : super(null);

  void refresh(List<Race>? list) {
    state = list?.sortedBy((element) => removeDiacritics(element.name.toLowerCase()));
  }

  void add(Race race) {
    refresh([...state ?? [], race]);
  }

  void update(String id, Race updated) {
    final index = state?.indexWhere((element) => element.id == id);
    if (null != index) {
      final list = [...state ?? []];
      list[index] = updated;

      refresh([...list]);
    }
  }

  void remove(String id) {
    state = state?.where((element) => element.id != id).toList();
  }

  void reject(String id, String reason) {
    final index = state?.indexWhere((element) => element.id == id);
    if (null != index) {
      final list = [...state ?? []];
      var race = list.removeAt(index);
      race = race.copyWith(state: SuggestionState.rejected, rejectionReason: reason);

      refresh([...list, race]);
    }
  }
}

final racesStateNotifierProvider = StateNotifierProvider<RacesStateNotifier, List<Race>?>((ref) {
  return RacesStateNotifier();
});
