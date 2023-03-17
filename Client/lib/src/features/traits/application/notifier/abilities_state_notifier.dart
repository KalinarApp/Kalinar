import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/traits/domain/suggestion_state.dart';

import '../../domain/ability.dart';

class AbilitiesStateNotifier extends StateNotifier<List<Ability>?> {
  AbilitiesStateNotifier() : super(null);

  void refresh(List<Ability>? list) {
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

  void add(Ability ability) {
    refresh([...state ?? [], ability]);
  }

  void update(String id, Ability updated) {
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
      var ability = list.removeAt(index);
      ability = ability.copyWith(state: SuggestionState.rejected, rejectionReason: reason);

      refresh([...list, ability]);
    }
  }

  void updateTags(String id, List<String> tags) {
    final index = state?.indexWhere((element) => element.id == id);
    if (null != index) {
      final list = [...state ?? []];
      list[index] = list[index].copyWith(tags: tags);

      refresh([...list]);
    }
  }
}

final abilitiesStateNotifierProvider = StateNotifierProvider<AbilitiesStateNotifier, List<Ability>?>((ref) {
  return AbilitiesStateNotifier();
});
