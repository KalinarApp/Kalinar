import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/attributes_repository.dart';
import '../domain/attribute.dart';

import 'attribute_list_controller.dart';

class AttributeController {
  final AttributesRepository repo;

  final AttributeListController attributeList;

  AttributeController(this.repo, this.attributeList);

  Future<Attribute> getById(String id) async {
    return await repo.getById(id);
  }

  Future<List<Attribute>> getAll() async {
    return await repo.getAll();
  }

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.createAttribute(data);
      attributeList.refresh();
    });
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return await AsyncValue.guard(() async {
      await repo.updateAttribute(id, data);
      attributeList.refresh();
    });
  }

  Future<AsyncValue> deleteSkill(String id) async {
    return await AsyncValue.guard(() async {
      await repo.deleteAttribute(id);
      attributeList.refresh();
    });
  }
}

final attributeControllerProvider = Provider<AttributeController>(
    (ref) => AttributeController(ref.read(attributesRepositoryProvider), ref.read(attributeListControllerProvider.notifier)));
