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

    return {"Authorization": "Bearer $idToken"};
  }

  Future<T> get<T>(String endpoint, T Function(dynamic response) responseBuilder) async {
    return await _handleResponse(() async => await http.get(Uri.https(baseUrl, endpoint), headers: await _getHeaders()), responseBuilder);
  }

  Future<T> post<T>(String endpoint, dynamic data, T Function(dynamic response) responseBuilder) async {
    var request = data != null ? json.encode(data) : null;
    return await _handleResponse(
        () async => await http.post(Uri.https(baseUrl, endpoint), body: request, headers: await _getHeaders()), responseBuilder);
  }

  Future<T> put<T>(String endpoint, dynamic data, T Function(dynamic response) responseBuilder) async {
    var request = data != null ? json.encode(data) : null;
    return await _handleResponse(
        () async => await http.put(Uri.https(baseUrl, endpoint), body: request, headers: await _getHeaders()), responseBuilder);
  }

  Future delete(String endpoint) async {
    return await _handleResponse(() async => await http.get(Uri.https(baseUrl, endpoint), headers: await _getHeaders()), (_) => true);
  }
}

@Riverpod(keepAlive: true)
KalinarHttpClient httpClient(HttpClientRef ref) {
  if (kDebugMode) HttpOverrides.global = DevHttpOverrides();
  return KalinarHttpClient(FlavorConfig.instance.variables["baseUrl"], ref.watch(authRepositoryProvider).currentUser);
}
