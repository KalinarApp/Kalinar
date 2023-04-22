import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/items_repository.dart';
import '../domain/item.dart';

class ItemsController extends StateNotifier<List<Item>> {
  final ItemsRepository repo;

  ItemsController(this.repo) : super([]);

  Future<AsyncValue> refresh() async {
    return await AsyncValue.guard(() async {
      final items = await repo.filter();
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

final itemsNotifierProvider = StateNotifierProvider<ItemsController, List<Item>>((ref) {
  return ItemsController(ref.watch(itemsRepositoryProvider));
});
