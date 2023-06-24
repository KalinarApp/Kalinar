import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../../group_management/application/group_notifier.dart';
import '../domain/race.dart';

class RacesRepository extends HeroBaseRepository {
  RacesRepository({super.notifier});

  Future<Race> getById(String id) async {
    return await heroGet("/api/races/$id", (response) => Race.fromJson(response));
  }

  Future<List<Race>> filter({String? query, List<String>? allowedStates}) async {
    return await heroGet(
      "/api/races",
      (response) => List<Race>.from(response.map((model) => Race.fromJson(model))),
      query: {"query": query, "allowedStates": allowedStates ?? []},
    );
  }

  Future<Race> createRace(Map<String, dynamic> data) async {
    return await heroPost("/api/races", data, (response) => Race.fromJson(response));
  }

  Future<void> reject(String id, String reason) async {
    await heroPost("/api/races/$id/reject", {"reason": reason}, (response) => true);
  }

  Future<Race> updateRace(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/races/$id", data, (response) => Race.fromJson(response));
  }

  Future<void> deleteRace(String id) async {
    await heroDelete("/api/races/$id");
  }
}

final racesRepositoryProvider = Provider<RacesRepository>((ref) => RacesRepository(notifier: ref.watch(groupNotifierProvider)));
