import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:http/http.dart' as http;
import 'package:kalinar/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'error_response.dart';

part 'kalinar_http_client.g.dart';

const apiVersion = "v1";
const apiVersionPath = "/api/$apiVersion";

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class KalinarHttpClient {
  final String baseUrl;
  final User? currentUser;

  const KalinarHttpClient(this.baseUrl, this.currentUser);

  Future<T> _handleResponse<T>(Future<http.Response> Function() action, T Function(dynamic response) responseBuilder) async {
    try {
      final response = await action();
      final responseData = response.body.isNotEmpty ? jsonDecode(response.body) : {};

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return responseBuilder(responseData);
      } else {
        throw ErrorResponse.fromJson(responseData);
      }
    } on SocketException catch (_) {
      throw ErrorResponse("NoInternetConnectionException", []);
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    final idToken = await currentUser?.getIdToken();

    return {
      "Authorization": "Bearer $idToken",
      "Content-Type": "application/json",
    };
  }

  Future<T> get<T>(String endpoint, T Function(dynamic response) responseBuilder, {Map<String, String> queryParameters = const {}}) async {
    final url = Uri.https(baseUrl, endpoint, queryParameters);
    return await _handleResponse(() async => await http.get(url, headers: await _getHeaders()), responseBuilder);
  }

  Future<T> post<T>(String endpoint, dynamic data, T Function(dynamic response) responseBuilder,
      {Map<String, String> queryParameters = const {}}) async {
    var request = data != null ? json.encode(data) : null;
    final url = Uri.https(baseUrl, endpoint, queryParameters);
    return await _handleResponse(() async => await http.post(url, body: request, headers: await _getHeaders()), responseBuilder);
  }

  Future<T> put<T>(String endpoint, dynamic data, T Function(dynamic response) responseBuilder,
      {Map<String, String> queryParameters = const {}}) async {
    var request = data != null ? json.encode(data) : null;
    final url = Uri.https(baseUrl, endpoint, queryParameters);
    return await _handleResponse(() async => await http.put(url, body: request, headers: await _getHeaders()), responseBuilder);
  }

  Future delete(String endpoint, {Map<String, String> queryParameters = const {}}) async {
    final url = Uri.https(baseUrl, endpoint, queryParameters);
    return await _handleResponse(() async => await http.get(url, headers: await _getHeaders()), (_) => true);
  }
}

@Riverpod(keepAlive: true)
KalinarHttpClient httpClient(HttpClientRef ref) {
  if (kDebugMode) HttpOverrides.global = DevHttpOverrides();
  return KalinarHttpClient(FlavorConfig.instance.variables["baseUrl"], ref.watch(authRepositoryProvider).currentUser);
}
