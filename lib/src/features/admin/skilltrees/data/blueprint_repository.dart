import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/blueprint.dart';
import '../domain/blueprint_overview.dart';

import '../../../../utilities/base_repository.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../group_management/application/has_group_controller.dart';

class BlueprintRepository extends HeroBaseRepository {
  static const String nodesKey = "currentNodes";

  BlueprintRepository(super.client, String? groupId) : super(groupId: groupId);

  Future<List<BlueprintOverview>> getAll() async {
    return await heroGet("/api/blueprints", (response) => List<BlueprintOverview>.from(response.map((model) => BlueprintOverview.fromJson(model))));
  }

  Future<Blueprint> getById(String id) async {
    return await heroGet("/api/blueprints/$id", (response) => Blueprint.fromJson(response));
  }

  Future<Blueprint> load(String id) async {
    return await heroGet("/api/blueprints/$id/load", (response) => Blueprint.fromJson(response));
  }

  Future<void> createOnServer(Map<String, dynamic> data) async {
    await heroPost("/api/blueprints", data, (response) => true);
  }

  Future<void> updateOnServer(String id, Map<String, dynamic> data) async {
    await heroUpdate("/api/blueprints/$id", data, (response) => true);
  }

  Future<void> deleteOnServer(String id) async {
    await heroDelete("/api/blueprints/$id");
  }
}

final blueprintRepositoryProvider = Provider<BlueprintRepository>((ref) {
  return BlueprintRepository(ref.read(authProvider), ref.read(hasGroupProvider).groupId);
});
