import 'dart:convert';
import 'dart:io';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;

import '../features/authentication/data/flutter_auth.dart';
import '../features/group_management/domain/group.dart';
import 'api_error.dart';

class BaseRepository {
  final FlutterAuth client;

  BaseRepository(this.client);

  Future<T> _handleResponse<T>(Future<http.Response> Function() action, T Function(dynamic response) responseBuilder) async {
    try {
      final response = await action();
      final data = response.body.isNotEmpty ? json.decode(response.body) : {};
      switch (response.statusCode) {
        case 200:
          return responseBuilder(data);
        case 400:
          throw APIError.badRequest(data["type"], data["title"]);
        case 401:
          throw const APIError.unauthorized();
        case 403:
          throw const APIError.forbidden();
        case 404:
          throw APIError.notFound(data["type"] ?? "", data["title"] ?? "");
        case 500:
          throw APIError.problem(data["type"], data["title"]);
        default:
          throw APIError.unknown(data["type"], data["title"]);
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    }
  }

  Future<T> get<T>(Uri url, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async => await client.get(url, headers: headers), builder);
  }

  Future<T> post<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async {
      Map<String, String> fullHeaders = {"content-type": "application/json", ...headers ?? {}};
      var encode = null != data ? json.encode(data) : null;
      return await client.post(url, body: encode, headers: fullHeaders);
    }, builder);
  }

  Future<T> update<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async {
      Map<String, String> fullHeaders = {"content-type": "application/json", ...headers ?? {}};
      var encode = json.encode(data);
      return await client.put(url, body: encode, headers: fullHeaders);
    }, builder);
  }

  Future<T> patch<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async {
      Map<String, String> fullHeaders = {"content-type": "application/json", ...headers ?? {}};
      var encode = json.encode(data);
      return await client.patch(url, body: encode, headers: fullHeaders);
    }, builder);
  }

  Future<void> delete(Uri url, {Map<String, String>? headers}) async {
    await _handleResponse(() async {
      return await client.delete(url, headers: headers);
    }, (response) => true);
  }
}

class HeroBaseRepository extends BaseRepository {
  Map<String, String>? headers;
  late final String baseUrl;

  HeroBaseRepository(super.client, {Group? group}) {
    baseUrl = FlavorConfig.instance.variables["baseUrl"];
    headers = null != group ? headers = {"Group": group.id} : headers = {};
  }

  Future<T> heroGet<T>(String url, T Function(dynamic response) builder, {Map<String, String>? query}) async {
    return await super.get(Uri.https(baseUrl, url, query), builder, headers: headers);
  }

  Future<T> heroPost<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    return await super.post(Uri.https(baseUrl, url), data, builder, headers: headers);
  }

  Future<T> heroUpdate<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    return await super.update(Uri.https(baseUrl, url), data, builder, headers: headers);
  }

  Future<T> heroPatch<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    return await super.patch(Uri.https(baseUrl, url), data, builder, headers: headers);
  }

  Future<void> heroDelete(String url) async {
    return await super.delete(Uri.https(baseUrl, url), headers: headers);
  }
}
