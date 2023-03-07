import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/attribute.dart';
import '../../domain/suggestion_state.dart';

class AttributesStateNotifier extends StateNotifier<List<Attribute>?> {
  AttributesStateNotifier() : super(null);

  void refresh(List<Attribute>? list) {
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

  void add(Attribute attribute) {
    refresh([...state ?? [], attribute]);
  }

  void update(String id, Attribute updated) {
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
      var attribute = list.removeAt(index);
      attribute = attribute.copyWith(state: SuggestionState.rejected, rejectionReason: reason);

      refresh([...list, attribute]);
    }
  }
}

final attributesStateNotifierProvider = StateNotifierProvider<AttributesStateNotifier, List<Attribute>?>((ref) {
  return AttributesStateNotifier();
});
