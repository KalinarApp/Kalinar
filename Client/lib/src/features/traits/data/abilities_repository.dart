import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../../group_management/application/group_notifier.dart';
import '../domain/ability.dart';

class AbilitiesRepository extends HeroBaseRepository {
  AbilitiesRepository({super.notifier});

  Future<Ability> getById(String id) async {
    return await heroGet("/api/abilities/$id", (response) => Ability.fromJson(response));
  }

  Future<List<Ability>> filter({String? query, List<String>? allowedStates}) async {
    return await heroGet(
      "/api/abilities",
      (response) => List<Ability>.from(response.map((model) => Ability.fromJson(model))),
      query: {"query": query, "allowedStates": allowedStates ?? []},
    );
  }

  Future<List<String>> getAllAvailableTags(String? query) async {
    return await heroGet("/api/abilities/tags", (response) => (response as List<dynamic>).cast<String>(), query: {"query": query});
  }

  Future<Ability> createAbility(Map<String, dynamic> data) async {
    return await heroPost("/api/abilities", data, (response) => Ability.fromJson(response));
  }

  Future updateAbilityTags(String id, List<String> tags) async {
    // final tagsList = jsonEncode(tags);
    await heroPost("/api/abilities/$id/tags", tags, (response) => true);
  }

  Future<void> reject(String id, String reason) async {
    await heroPost("/api/abilities/$id/reject", {"reason": reason}, (response) => true);
  }

  Future<Ability> updateAbility(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/abilities/$id", data, (response) => Ability.fromJson(response));
  }

  Future<void> deleteAbility(String id) async {
    await heroDelete("/api/abilities/$id");
  }
}

final abilitiesRepositoryProvider = Provider<AbilitiesRepository>((ref) => AbilitiesRepository(notifier: ref.watch(groupNotifierProvider)));
