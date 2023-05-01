import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../../group_management/application/group_notifier.dart';
import '../domain/item.dart';

class ItemsRepository extends HeroBaseRepository {
  ItemsRepository({super.group});

  Future<List<Item>> filter({String? query, bool? isLocked}) async {
    return await heroGet(
      "api/items",
      (response) => List<Item>.from(response.map((model) => Item.fromJson(model))),
      query: {"query": query, "isLocked": isLocked},
    );
  }

  Future<Item> create(Map<String, dynamic> data) async {
    return await heroPost("api/items", data, (response) => Item.fromJson(response));
  }
}

final itemsRepositoryProvider = Provider<ItemsRepository>((ref) {
  return ItemsRepository(group: ref.watch(groupNotifierProvider).group);
});
