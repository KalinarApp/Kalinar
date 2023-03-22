import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/skill.dart';
import '../../domain/suggestion_state.dart';

class SkillsStateNotifier extends StateNotifier<List<Skill>?> {
  SkillsStateNotifier() : super(null);

  void refresh(List<Skill>? list) {
    state = list?.sortedBy((element) => removeDiacritics(element.name.toLowerCase()));
  }

  void add(Skill skill) {
    refresh([...state ?? [], skill]);
  }

  void update(String id, Skill updated) {
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
}

final skillsStateNotifierProvider = StateNotifierProvider<SkillsStateNotifier, List<Skill>?>((ref) {
  return SkillsStateNotifier();
});
