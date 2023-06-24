import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../domain/character.dart';
import '../domain/character_overview.dart';

class CharactersRepository extends HeroBaseRepository {
  CharactersRepository();

  Future<Character> getById(String id) async {
    return await heroGet("/api/characters/$id", (response) => Character.fromJson(response));
  }

  Future<List<CharacterOverview>> getAll({bool? isOwner}) async {
    return await heroGet(
      "/api/characters",
      (response) => List<CharacterOverview>.from(response.map((model) => CharacterOverview.fromJson(model))),
      query: {"isOwner": isOwner?.toString()},
    );
  }

  Future<List<CharacterOverview>> getAllExtended({bool? isOwner}) async {
    return await heroGet(
      "/api/characters/extended",
      (response) => List<CharacterOverview>.from(response.map((model) => CharacterOverview.fromJson(model))),
      query: {"isOwner": isOwner?.toString()},
    );
  }

  Future<CharacterOverview> createCharacter(Map<String, dynamic> data) async {
    return await heroPost("/api/characters", data, (response) => CharacterOverview.fromJson(response));
  }

  Future<Character> updateCharacter(String id, Map<String, dynamic> data) async {
    return await heroPatch("/api/characters/$id", data, (response) => Character.fromJson(response));
  }

  Future<void> deleteCharacter(String id) async {
    await heroDelete("/api/characters/$id");
  }
}

final charactersRepositoryProvider = Provider<CharactersRepository>((ref) {
  return CharactersRepository();
});
