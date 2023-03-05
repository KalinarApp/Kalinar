import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/ability.dart';

class AbilityStateNotifier extends StateNotifier<AsyncValue<Ability>> {
  AbilityStateNotifier() : super(const AsyncLoading());

  void set(AsyncValue<Ability> value) {
    state = value;
  }
}

final abilityStateNotifierProvider = StateNotifierProvider<AbilityStateNotifier, AsyncValue<Ability>>((ref) {
  return AbilityStateNotifier();
});
