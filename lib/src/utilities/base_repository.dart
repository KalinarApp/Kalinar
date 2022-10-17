import 'dart:convert';
import 'dart:io';

import 'package:flutter_auth/flutter_auth.dart';

import 'api_error.dart';

class BaseRepository {
  final FlutterAuth _client;

  BaseRepository(this._client);

  Future<T> get<T>(Uri url, T Function(dynamic response) builder) async {
    try {
      final response = await _client.get(url);
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
      var encode = json.encode(data);
      final response = await _client.post(url, body: encode, headers: headers);
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
      final response = await _client.put(url, body: encode, headers: headers);
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
