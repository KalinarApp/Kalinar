import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';
import 'package:hero/src/utilities/base_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/node.dart';

class SkilltreesRepository extends HeroBaseRepository {
  static const String nodesKey = "currentNodes";

  SkilltreesRepository(super.client);

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

  Future<void> createOnServer(Map<String, dynamic> data) async {
    await heroPost("/api/skilltrees", data, (response) => true);
  }
}

final skilltreesRepositoryProvider = Provider<SkilltreesRepository>((ref) {
  return SkilltreesRepository(ref.read(authProvider));
});
