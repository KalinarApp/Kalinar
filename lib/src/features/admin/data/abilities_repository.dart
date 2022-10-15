import 'dart:convert';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/data/base_repository.dart';

import '../../../utilities/constants.dart';
import '../../authentication/data/auth_repository.dart';
import '../domain/ability.dart';

class AbilitiesRepository extends BaseRepository {
  AbilitiesRepository(FlutterAuth client) : super(client);

  Future<Ability> getByName(String name) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities/$name");
    return await get(url, (response) => Ability.fromJson(response));
  }

  Future<List<Ability>> getAll() async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities");
    return await get(url, (response) => List<Ability>.from(response.map((model) => Ability.fromJson(model))));
  }

  Future<List<Ability>> filter(String query) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities", {"search": query});
    return await get(url, (response) => List<Ability>.from(response.map((model) => Ability.fromJson(model))));
  }

  Future<Ability> createAbility(Map<String, dynamic> data) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities");
    return await post(url, data, (response) => Ability.fromJson(json.decode(response)));
  }

  Future<Ability> updateAbility(String name, Map<String, dynamic> data) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities/$name");
    return await update(url, data, (response) => Ability.fromJson(json.decode(response)));
  }

  Future<bool> deleteAbility(String name) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities/$name");
    return await delete(url);
  }
}

final abilitiesRepositoryProvider = Provider<AbilitiesRepository>((ref) => AbilitiesRepository(ref.read(authProvider)));
