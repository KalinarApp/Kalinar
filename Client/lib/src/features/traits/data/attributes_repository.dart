import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/base_repository.dart';
import '../domain/attribute.dart';

class AttributesRepository extends HeroBaseRepository {
  AttributesRepository();

  Future<Attribute> getById(String id) async {
    return await heroGet("/api/attributes/$id", (response) => Attribute.fromJson(response));
  }

  Future<List<Attribute>> filter({String? query, bool? globalOnly, List<String>? allowedStates}) async {
    return await heroGet(
      "/api/attributes",
      (response) => List<Attribute>.from(response.map((model) => Attribute.fromJson(model))),
      query: {"query": query, "onlyGlobal": globalOnly?.toString(), "allowedStates": allowedStates ?? []},
    );
  }

  Future<List<String>> getFilteredCategories(String? query) async {
    return await heroGet(
      "/api/attributes/categories",
      (response) => List<String>.from(response.map((model) => model)),
      query: {"query": query ?? ""},
    );
  }

  Future<Attribute> createAttribute(Map<String, dynamic> data) async {
    return await heroPost("/api/attributes", data, (response) => Attribute.fromJson(response));
  }

  Future reject(String id, String reason) async {
    await heroPost("/api/attributes/$id/reject", {"reason": reason}, (response) => true);
  }

  Future<Attribute> updateAttribute(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/attributes/$id", data, (response) => Attribute.fromJson(response));
  }

  Future<void> deleteAttribute(String id) async {
    return await heroDelete("/api/attributes/$id");
  }
}

final attributesRepositoryProvider = Provider<AttributesRepository>((ref) => AttributesRepository());
