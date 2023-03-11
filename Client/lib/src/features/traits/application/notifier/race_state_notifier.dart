import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/race.dart';

class RaceStateNotifier extends StateNotifier<AsyncValue<Race>> {
  RaceStateNotifier() : super(const AsyncLoading());

  void set(AsyncValue<Race> value) {
    state = value;
  }
}

final raceStateNotifierProvider = StateNotifierProvider<RaceStateNotifier, AsyncValue<Race>>((ref) {
  return RaceStateNotifier();
});
