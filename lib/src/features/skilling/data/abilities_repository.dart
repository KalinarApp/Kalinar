import 'dart:convert';
import 'dart:io';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/api_error.dart';
import '../../../utilities/constants.dart';
import '../../authentication/data/auth_repository.dart';
import '../domain/ability.dart';

class AbilitiesRepository {
  final FlutterAuth client;

  AbilitiesRepository(this.client);

  Future<T> _getData<T>({required Uri uri, required T Function(dynamic data) builder}) async {
    try {
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
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

  Future<List<Ability>> getAll() async => await _getData<List<Ability>>(
      uri: Uri.https(Constants.baseUrl, "/api/abilities"), builder: (data) => List<Ability>.from(data.map(Ability.fromJson)));
}

final abilitiesRepositoryProvider = Provider<AbilitiesRepository>((ref) => AbilitiesRepository(ref.read(authProvider)));
