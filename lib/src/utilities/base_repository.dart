import 'dart:convert';
import 'dart:io';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

import 'api_error.dart';

class BaseRepository {
  final FlutterAuth client;

  BaseRepository(this.client);

  Future<T> get<T>(Uri url, T Function(dynamic response) builder) async {
    try {
      final response = await client.get(url);
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

  Future<T> post<T>(Uri url, dynamic data, T Function(dynamic response) builder) async {
    Map<String, String> headers = {
      "content-type": "application/json",
    };

    try {
      var encode = null != data ? json.encode(data) : null;
      final response = await client.post(url, body: encode, headers: headers);
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

  Future<T> update<T>(Uri url, dynamic data, T Function(dynamic response) builder) async {
    Map<String, String> headers = {
      "content-type": "application/json",
    };

    try {
      var encode = json.encode(data);
      final response = await client.put(url, body: encode, headers: headers);
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

  Future<bool> delete(Uri url) async {
    bool success = false;
    try {
      final response = await client.delete(url);
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
  late final String baseUrl;

  HeroBaseRepository(super.client) {
    baseUrl = FlavorConfig.instance.variables["baseUrl"];
  }

  Future<T> heroGet<T>(String url, T Function(dynamic response) builder, {Map<String, String>? query}) async {
    return await super.get(Uri.https(baseUrl, url, query), builder);
  }

  Future<T> heroPost<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    return await super.post(Uri.https(baseUrl, url), data, builder);
  }

  Future<T> heroUpdate<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    return await super.update(Uri.https(baseUrl, url), data, builder);
  }

  Future<bool> heroDelete(String url) async {
    return await super.delete(Uri.https(baseUrl, url));
  }
}
