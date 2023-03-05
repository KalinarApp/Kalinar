import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../traits/data/attributes_repository.dart';
import '../../../traits/domain/attribute.dart';

class AttributeListController extends StateNotifier<AsyncValue<List<Attribute>>> {
  final AttributesRepository repo;

  AttributeListController(this.repo) : super(const AsyncLoading());

  Future<void> getAllAttributes() async {
    state = const AsyncLoading();
    await refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async => repo.getAll());
  }
}

final attributeListControllerProvider = StateNotifierProvider<AttributeListController, AsyncValue<List<Attribute>>>(
    (ref) => AttributeListController(ref.watch(attributesRepositoryProvider)));
