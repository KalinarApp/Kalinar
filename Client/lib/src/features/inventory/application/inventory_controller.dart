import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/item.dart';
import '../presentation/inventory_dummy.dart';

class InventoryController extends StateNotifier<List<Item>> {
  final String characterId;

  InventoryController(this.characterId) : super([]);

  Future<AsyncValue> refresh() async {
    return await AsyncValue.guard(() async {
      state = items;
    });
  }

  Future<AsyncValue> add(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      final item = Item.fromJson(data);
      state = [...state, item];
    });
  }

  Future<AsyncValue> remove(String id) async {
    return await AsyncValue.guard(() async {
      state = state.whereNot((element) => element.id == id).toList();
    });
  }
}
