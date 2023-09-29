import 'dart:async';

import 'package:kalinar/src/utils/http/ref_extensions.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../utils/http/kalinar_http_client.dart';
import '../domain/ability.dart';

part 'ability_repository.g.dart';

class AbilityRepository {
  final KalinarHttpClient client;

  AbilityRepository(this.client);

  Future<List<Ability>> list(String groupId) async {
    return client.get(
      "$apiVersionPath/abilities",
      (response) => List<Ability>.from(response.map((model) => Ability.fromJson(model))),
      queryParameters: {"groupId": groupId},
    );
  }

  Future<List<String>> listTagsByGroupId(String groupId) async {
    return client.get(
      "$apiVersionPath/abilities/tags",
      (response) => List<String>.from(response.map((model) => model)),
      queryParameters: {"groupId": groupId},
    );
  }

  Future<List<String>> listTagsByAbilityId(String abilityId) async {
    return client.get(
      "$apiVersionPath/abilities/$abilityId/tags",
      (response) => List<String>.from(response.map((model) => model)),
    );
  }

  Future<Ability> getById(String abilityId) async {
    return client.get("$apiVersionPath/abilities/$abilityId", (response) => Ability.fromJson(response));
  }

  Future<Ability> create(Ability ability) async {
    return client.post("$apiVersionPath/abilities", ability, (response) => Ability.fromJson(response));
  }

  Future<Ability> update(String abilityId, Ability ability) async {
    return client.put("$apiVersionPath/abilities/$abilityId", ability, (response) => Ability.fromJson(response));
  }

  Future setTags(String abilityId, List<String> tags) async {
    return client.post("$apiVersionPath/abilities/$abilityId/tags", tags, (response) => true);
  }

  Future<Ability> approve(String abilityId) async {
    return client.post("$apiVersionPath/abilities/$abilityId/approve", {}, (response) => Ability.fromJson(response));
  }

  Future<Ability> reject(String abilityId, String rejectionReason) async {
    return client.post("$apiVersionPath/abilities/$abilityId/reject", {"rejectionReason": rejectionReason}, (response) => Ability.fromJson(response));
  }

  Future delete(String abilityId) async {
    return client.delete("$apiVersionPath/abilities/$abilityId");
  }
}

@Riverpod(keepAlive: true)
AbilityRepository abilityRepository(AbilityRepositoryRef ref) {
  return AbilityRepository(ref.watch(httpClientProvider));
}

@riverpod
FutureOr<Ability> getAbilityById(GetAbilityByIdRef ref, String abilityId) {
  ref.cacheFor();
  return ref.watch(abilityRepositoryProvider).getById(abilityId);
}

@riverpod
FutureOr<List<Ability>> listAbilities(ListAbilitiesRef ref, String groupId) {
  ref.cacheFor(duration: const Duration(seconds: 30));

  return ref.watch(abilityRepositoryProvider).list(groupId);
}

@riverpod
FutureOr<List<String>> listAbilityTagsByGroupId(ListAbilityTagsByGroupIdRef ref, String groupId) {
  ref.cacheFor();

  return ref.watch(abilityRepositoryProvider).listTagsByGroupId(groupId);
}

@riverpod
FutureOr<List<String>> listAbilityTagsByAbilityId(ListAbilityTagsByAbilityIdRef ref, String abilityId) {
  ref.cacheFor();

  return ref.watch(abilityRepositoryProvider).listTagsByAbilityId(abilityId);
}
