import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/traits/domain/suggestion_state.dart';

import '../../domain/race.dart';

class RacesStateNotifier extends StateNotifier<List<Race>?> {
  RacesStateNotifier() : super(null);

  void refresh(List<Race>? list) {
    list?.sort((a, b) {
      int dateComparison = a.createdAt.compareTo(b.createdAt);
      if (dateComparison != 0) {
        return dateComparison;
      } else {
        return a.name.compareTo(b.name);
      }
    });
    state = list;
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
