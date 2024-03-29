import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_error.dart';
import 'constants.dart';

class BaseRepository {
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
          throw const APIError.notFound();
        case 500:
          throw APIError.problem(data["type"], data["title"]);
        default:
          throw const APIError.unknown();
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    } catch (error) {
      throw const APIError.unknown();
    }
  }

  Future<Map<String, String>> getDefaultHeaders() async {
    final idToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    return {
      "Authorization": "Bearer $idToken",
      "content-type": "application/json",
      "Access-Control-Allow-Origin": "*",
    };
  }

  Future<T> get<T>(Uri url, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async => await http.get(url, headers: {...await getDefaultHeaders(), ...headers ?? {}}), builder);
  }

  Future<T> post<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async {
      var encode = null != data ? json.encode(data) : null;
      return await http.post(url, body: encode, headers: {...await getDefaultHeaders(), ...headers ?? {}});
    }, builder);
  }

  Future<T> update<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async {
      var encode = json.encode(data);
      return await http.put(url, body: encode, headers: {...await getDefaultHeaders(), ...headers ?? {}});
    }, builder);
  }

  Future<T> patch<T>(Uri url, dynamic data, T Function(dynamic response) builder, {Map<String, String>? headers}) async {
    return await _handleResponse(() async {
      var encode = json.encode(data);
      return await http.patch(url, body: encode, headers: {...await getDefaultHeaders(), ...headers ?? {}});
    }, builder);
  }

  Future<void> delete(Uri url, {Map<String, String>? headers}) async {
    await _handleResponse(() async {
      return await http.delete(url, headers: {...await getDefaultHeaders(), ...headers ?? {}});
    }, (response) => true);
  }
}

class HeroBaseRepository extends BaseRepository {
  final String baseUrl;

  String? currentGroup;

  HeroBaseRepository() : baseUrl = FlavorConfig.instance.variables["baseUrl"];

  Future<Map<String, String>> getHeaders() async {
    if (currentGroup != null) return {"x-kalinar-group": currentGroup!};

    final prefs = await SharedPreferences.getInstance();
    currentGroup = prefs.getString(Constants.currentGroupKey);

    if (currentGroup == null) return {};

    return {"x-kalinar-group": currentGroup!};
  }

  Future<T> heroGet<T>(String url, T Function(dynamic response) builder, {Map<String, dynamic>? query}) async {
    Map<String, String> headers = await getHeaders();
    return await super.get(Uri.https(baseUrl, url, query), builder, headers: headers);
  }

  Future<T> heroPost<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    Map<String, String> headers = await getHeaders();
    return await super.post(Uri.https(baseUrl, url), data, builder, headers: headers);
  }

  Future<T> heroUpdate<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    Map<String, String> headers = await getHeaders();
    return await super.update(Uri.https(baseUrl, url), data, builder, headers: headers);
  }

  Future<T> heroPatch<T>(String url, dynamic data, T Function(dynamic response) builder) async {
    Map<String, String> headers = await getHeaders();
    return await super.patch(Uri.https(baseUrl, url), data, builder, headers: headers);
  }

  Future<void> heroDelete(String url) async {
    Map<String, String> headers = await getHeaders();
    return await super.delete(Uri.https(baseUrl, url), headers: headers);
  }
}
