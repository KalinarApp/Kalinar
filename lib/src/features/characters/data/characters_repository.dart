import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../../authentication/data/auth_repository.dart';
import '../../group_management/application/has_group_controller.dart';
import '../domain/character.dart';
import '../domain/character_overview.dart';

class CharactersRepository extends HeroBaseRepository {
  CharactersRepository(super.client, String? groupId) : super(groupId: groupId);

  Future<Character> getById(String id) async {
    return await heroGet("/api/characters/$id", (response) => Character.fromJson(response));
  }

  Future<List<CharacterOverview>> getAll() async {
    return await heroGet("/api/characters", (response) => List<CharacterOverview>.from(response.map((model) => CharacterOverview.fromJson(model))));
  }

  Future<void> createCharacter(Map<String, dynamic> data) async {
    return await heroPost("/api/characters", data, (response) => true);
  }

  Future<void> updateCharacter(String id, Map<String, dynamic> data) async {
    return await heroUpdate("/api/characters/$id", data, (response) => true);
  }

  Future<void> deleteCharacter(String id) async {
    await heroDelete("/api/characters/$id");
  }
}

final charactersRepositoryProvider =
    Provider<CharactersRepository>((ref) => CharactersRepository(ref.read(authProvider), ref.read(hasGroupProvider).groupId));
