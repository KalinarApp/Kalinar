import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/race.dart';

import '../../../../utilities/base_repository.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../group_management/application/has_group_controller.dart';

class RacesRepository extends HeroBaseRepository {
  RacesRepository(super.client, String? groupId) : super(groupId: groupId);

  Future<List<Race>> getAll() async {
    return await heroGet("/api/races", (response) => List<Race>.from(response.map((model) => Race.fromJson(model))));
  }

  Future<Race> createRace(Map<String, dynamic> data) async {
    return await heroPost("/api/races", data, (response) => Race.fromJson(json.decode(response)));
  }

  Future<Race> updateRace(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/races/$id", data, (response) => Race.fromJson(json.decode(response)));
  }

  Future<bool> deleteRace(String id) async {
    return await heroDelete("/api/races/$id");
  }
}

final racesRepositoryProvider = Provider<RacesRepository>((ref) => RacesRepository(ref.read(authProvider), ref.read(hasGroupProvider).groupId));
