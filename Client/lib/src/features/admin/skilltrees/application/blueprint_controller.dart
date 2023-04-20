import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/blueprint_repository.dart';
import '../domain/blueprint.dart';
import 'blueprint_list_controller.dart';

class BlueprintController {
  final BlueprintRepository repo;
  final BlueprintListController listController;

  BlueprintController(this.repo, this.listController) : super();

  Future<AsyncValue> create(Map<String, dynamic> data) async {
    return AsyncValue.guard(() async {
      await repo.createOnServer(data);
      await listController.refresh();
    });
  }

  Future<AsyncValue> update(String id, Map<String, dynamic> data) async {
    return AsyncValue.guard(() async {
      await repo.updateOnServer(id, data);
      await listController.refresh();
    });
  }

  Future<Blueprint> getById(String id) async {
    return await repo.getById(id);
  }

  Future<Blueprint> load(String id) async {
    return await repo.load(id);
  }

  Future<AsyncValue> delete(String id) async {
    return AsyncValue.guard(() async {
      await repo.deleteOnServer(id);
      await listController.refresh();
    });
  }
}

final blueprintControllerProvider = Provider<BlueprintController>((ref) {
  return BlueprintController(ref.watch(blueprintRepositoryProvider), ref.watch(blueprintListControllerProvider.notifier));
});
