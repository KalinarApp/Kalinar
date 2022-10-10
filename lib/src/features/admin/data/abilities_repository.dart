import 'dart:convert';
import 'dart:io';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/api_error.dart';
import '../../../utilities/constants.dart';
import '../../authentication/data/auth_repository.dart';
import '../domain/ability.dart';

class AbilitiesRepository {
  final FlutterAuth _client;

  AbilitiesRepository(this._client);

  Future<List<Ability>> getAll() async {
    try {
      final response = await _client.get(Uri.https(Constants.baseUrl, "/api/abilities"));
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return List<Ability>.from(data.map((model) => Ability.fromJson(model)));
        case 401:
          throw const APIError.unauthorized();
        case 404:
          throw const APIError.notFound();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }

  Future<Ability> createAbility(Map<String, dynamic> data) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities");

    Map<String, String> headers = {
      "content-type": "application/json",
    };

    try {
      var encode = json.encode(Ability.fromJson(data));
      final response = await _client.post(url, body: encode, headers: headers);
      switch (response.statusCode) {
        case 200:
          return Ability.fromJson(json.decode(response.body));
        case 400:
          throw const APIError.badRequest();
        case 401:
          throw const APIError.unauthorized();
        case 404:
          throw const APIError.notFound();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }

  Future<Ability> updateAbility(String name, Map<String, dynamic> data) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities/$name");

    Map<String, String> headers = {
      "content-type": "application/json",
    };

    try {
      var encode = json.encode(Ability.fromJson(data));
      final response = await _client.put(url, body: encode, headers: headers);
      switch (response.statusCode) {
        case 200:
          return Ability.fromJson(json.decode(response.body));
        case 400:
          throw const APIError.badRequest();
        case 401:
          throw const APIError.unauthorized();
        case 404:
          throw const APIError.notFound();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }

  Future<bool> deleteAbility(String name) async {
    final url = Uri.https(Constants.baseUrl, "/api/abilities/$name");
    bool success = false;

    try {
      final response = await _client.delete(url);
      switch (response.statusCode) {
        case 200:
          success = true;
          break;
        case 400:
          throw const APIError.badRequest();
        case 401:
          throw const APIError.unauthorized();
        case 404:
          throw const APIError.notFound();
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }

    return success;
  }
}

final abilitiesRepositoryProvider = Provider<AbilitiesRepository>((ref) => AbilitiesRepository(ref.read(authProvider)));
