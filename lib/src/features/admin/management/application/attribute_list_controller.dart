import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/attribute.dart';

import '../data/attributes_repository.dart';

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
    (ref) => AttributeListController(ref.read(attributesRepositoryProvider)));
