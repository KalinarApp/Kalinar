import 'dart:convert';
import 'dart:io';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';
import 'package:hero/src/utilities/api_error.dart';

import '../../../utilities/constants.dart';
import '../domain/group.dart';

class GroupRepository {
  final FlutterAuth _client;

  GroupRepository(this._client);

  Future<Group?> createGroup(Map<String, dynamic> data) async {
    final url = Uri.https(Constants.baseUrl, "/api/groups");

    Map<String, String> headers = {
      "content-type": "application/json",
    };

    try {
      var encode = json.encode(Group.fromJson(data));
      final response = await _client.post(url, body: encode, headers: headers);
      switch (response.statusCode) {
        case 200:
          return Group.fromJson(json.decode(response.body));
        case 400:
          throw const APIError.groupAlreadyExist();
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
}

final groupRepositoryProvider = Provider<GroupRepository>((ref) {
  return GroupRepository(ref.read(authProvider));
});
