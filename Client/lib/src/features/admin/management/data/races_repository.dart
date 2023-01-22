import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/base_repository.dart';
import '../../../group_management/application/group_notifier.dart';
import '../domain/race.dart';

class RacesRepository extends HeroBaseRepository {
  RacesRepository({super.group});

  Future<List<Race>> getAll() async {
    return await heroGet("/api/races", (response) => List<Race>.from(response.map((model) => Race.fromJson(model))));
  }

  Future<Race> createRace(Map<String, dynamic> data) async {
    return await heroPost("/api/races", data, (response) => Race.fromJson(response));
  }

  Future<Race> updateRace(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/races/$id", data, (response) => Race.fromJson(response));
  }

  Future<void> deleteRace(String id) async {
    return await heroDelete("/api/races/$id");
  }
}

final racesRepositoryProvider = Provider<RacesRepository>((ref) => RacesRepository(group: ref.watch(groupNotifierProvider).group));
