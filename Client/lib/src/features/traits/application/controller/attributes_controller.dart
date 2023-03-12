import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/traits/application/controller/traits_controller.dart';

import '../../data/attributes_repository.dart';
import '../../domain/attribute.dart';
import '../../domain/suggestion_state.dart';
import '../notifier/attribute_state_notifier.dart';
import '../notifier/attributes_state_notifier.dart';

class AttributesController implements TraitsController {
  final AttributesRepository repo;
  final AttributesStateNotifier notifier;
  final AttributeStateNotifier attribute;

  AttributesController(this.repo, this.notifier, this.attribute);

  @override
  Future getById(String id) async {
    attribute.set(const AsyncLoading());
    attribute.set(await AsyncValue.guard(() async => await repo.getById(id)));
  }

  @override
  Future<AsyncValue> filter(String? query, {List<SuggestionState>? allowedStates}) async {
    return AsyncValue.guard(
        () async => notifier.refresh(await repo.filter(query: query, allowedStates: allowedStates?.map((e) => e.index.toString()).toList())));
  }

  Future<List<String>> getCategories(String? query) async {
    return await repo.getFilteredCategories(query);
  }

  Future<List<Attribute>> getAllGlobal() async {
    return await repo.filter(globalOnly: true);
  }

  Future<List<Attribute>> search({String? query, List<SuggestionState>? allowedStates}) async {
    final states = allowedStates?.map((e) => e.index.toString()).toList();
    return await repo.filter(query: query, allowedStates: states);
  }

  @override
  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async => notifier.add(await repo.createAttribute(data)));
  }

  @override
  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async => notifier.update(id, await repo.updateAttribute(id, data)));
  }

  @override
  Future<AsyncValue> delete(String id) async {
    return await AsyncValue.guard(() async {
      notifier.remove(id);
      await repo.deleteAttribute(id);
    });
  }

  @override
  Future<AsyncValue> reject(String id, String reason) async {
    return await AsyncValue.guard(() async {
      await repo.reject(id, reason);
      notifier.reject(id, reason);
    });
  }
}

final attributesControllerProvider = Provider<AttributesController>((ref) {
  return AttributesController(
    ref.watch(attributesRepositoryProvider),
    ref.watch(attributesStateNotifierProvider.notifier),
    ref.watch(attributeStateNotifierProvider.notifier),
  );
});
