import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/character.dart';

class CharacterStateNotifier extends StateNotifier<Character?> {
  CharacterStateNotifier() : super(null);

  void refresh(Character? item) {
    state = item;
  }
}

final characterStateProvider = StateNotifierProvider<CharacterStateNotifier, Character?>((ref) {
  return CharacterStateNotifier();
});
