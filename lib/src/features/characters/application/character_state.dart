import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/character.dart';

class CharacterState extends StateNotifier<AsyncValue<Character>> {
  CharacterState() : super(const AsyncLoading());

  
}
