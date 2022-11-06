import 'dart:convert';
import 'dart:io';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'api_error.dart';

class BaseRepository {
  final FlutterAuth client;

  BaseRepository(this.client);

  Future<T> get<T>(Uri url, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    try {
      final response = await client.get(url, headers: headers);
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

  Future<T>post<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    Map<String, String> fullHeaders = {"content-type": "application/json", ...headers ?? {}};

    try {
      var encode = null != data ? json.encode(data) : null;
      final response = await client.post(url, body: encode, headers: fullHeaders);
      switch (response.statusCode) {
        case 200:
          return builder(response.body);
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

  Future<T> update<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    Map<String, String> fullHeaders = {"content-type": "application/json", ...headers ?? {}};

    try {
      var encode = json.encode(data);
      final response = await client.put(url, body: encode, headers: fullHeaders);
      switch (response.statusCode) {
        case 200:
          return builder(response.body);
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

  Future<bool> delete(Uri url, {Map<String, String>? headers}) async {
    bool success = false;
    try {
      final response = await client.delete(url, headers: headers);
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

class HeroBaseRepository extends BaseRepository {
  Map<String, String>? headers;
  late final String baseUrl;

  HeroBaseRepository(super.client, {String? groupId}) {
    baseUrl = FlavorConfig.instance.variables["baseUrl"];
    headers = null != groupId ? headers = {"Group": groupId} : headers = {};
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

  Future<bool> heroDelete(String url) async {
    return await super.delete(Uri.https(baseUrl, url), headers: headers);
  }
}
