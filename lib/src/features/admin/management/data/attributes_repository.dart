import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kalinar/src/features/group_management/application/group_notifier.dart';

import '../../../../utilities/base_repository.dart';
import '../../../authentication/data/auth_repository.dart';
import '../domain/attribute.dart';

class AttributesRepository extends HeroBaseRepository {
  AttributesRepository(super.client, {super.group});

  Future<Attribute> getById(String id) async {
    return await heroGet("/api/attributes/$id", (response) => Attribute.fromJson(response));
  }

  Future<List<Attribute>> getAll() async {
    return await heroGet("/api/attributes", (response) => List<Attribute>.from(response.map((model) => Attribute.fromJson(model))));
  }

  Future<List<Attribute>> getAllGlobal() async {
    return await heroGet("/api/attributes/global", (response) => List<Attribute>.from(response.map((model) => Attribute.fromJson(model))));
  }

  Future<Attribute> createAttribute(Map<String, dynamic> data) async {
    return await heroPost("/api/attributes", data, (response) => Attribute.fromJson(response));
  }

  Future<Attribute> updateAttribute(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/attributes/$id", data, (response) => Attribute.fromJson(response));
  }

  Future<void> deleteAttribute(String id) async {
    return await heroDelete("/api/attributes/$id");
  }
}

final attributesRepositoryProvider =
    Provider<AttributesRepository>((ref) => AttributesRepository(ref.watch(authProvider), group: ref.watch(groupNotifierProvider).group));
