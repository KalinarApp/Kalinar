import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/attribute.dart';

class AttributeStateNotifier extends StateNotifier<AsyncValue<Attribute>> {
  AttributeStateNotifier() : super(const AsyncLoading());

  void set(AsyncValue<Attribute> value) {
    state = value;
  }
}

final attributeStateNotifierProvider = StateNotifierProvider<AttributeStateNotifier, AsyncValue<Attribute>>((ref) {
  return AttributeStateNotifier();
});
