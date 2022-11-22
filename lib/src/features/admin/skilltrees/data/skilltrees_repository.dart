import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/skilltrees/domain/skilltree.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utilities/base_repository.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../group_management/application/has_group_controller.dart';
import '../domain/node.dart';
import '../domain/skilltree_overview.dart';

class SkilltreesRepository extends HeroBaseRepository {
  static const String nodesKey = "currentNodes";

  SkilltreesRepository(super.client, String? groupId) : super(groupId: groupId);

  Future<List<Node>> loadLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(SkilltreesRepository.nodesKey);
    if (null != data) {
      return List<Node>.from(data.map((model) => Node.fromJson(json.decode(model))));
    }

    return [];
  }

  Future<void> deleteLocal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SkilltreesRepository.nodesKey);
  }

  Future<void> saveLocal(List<Node> nodes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(SkilltreesRepository.nodesKey, nodes.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<List<SkilltreeOverview>> getAll() async {
    return await heroGet("/api/skilltrees", (response) => List<SkilltreeOverview>.from(response.map((model) => SkilltreeOverview.fromJson(model))));
  }

  Future<Skilltree> getById(String id) async {
    return await heroGet("/api/skilltrees/$id", (response) => Skilltree.fromJson(response));
  }

  Future<void> createOnServer(Map<String, dynamic> data) async {
    await heroPost("/api/skilltrees", data, (response) => true);
  }

  Future<void> unlockNode(String skilltreeId, String nodeId) async {
    return await heroPost("/api/skilltrees/$skilltreeId/nodes/$nodeId/unlock", null, (response) => true);
  }

  Future<void> updateOnServer(String id, Map<String, dynamic> data) async {
    await heroUpdate("/api/skilltrees/$id", data, (response) => true);
  }

  Future<void> deleteOnServer(String id) async {
    await heroDelete("/api/skilltrees/$id");
  }
}

final skilltreesRepositoryProvider = Provider<SkilltreesRepository>((ref) {
  return SkilltreesRepository(ref.read(authProvider), ref.read(hasGroupProvider).groupId);
});
