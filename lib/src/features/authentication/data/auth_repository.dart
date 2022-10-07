import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_auth/models/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utilities/api_error.dart';
import '../../../utilities/constants.dart';

class AuthRepository {
  final FlutterAuth _client;

  AuthRepository(this._client);

  Future<void> _createUser() async {
    final url = Uri.https(Constants.baseUrl, "/api/users");
    try {
      final response = await _client.post(url);
      switch (response.statusCode) {
        case 200:
          break;
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

  Future<void> init() async {
    await _client.init();
  }

  Future<void> login() async {
    if (await _client.login()) {
      await _createUser();
    }
  }

  Future<void> logout() async {
    await _client.logout();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read(authProvider)));

final authProvider = Provider<FlutterAuth>((ref) {
  FlutterAuth auth = FlutterAuth.initialize(
    Constants.authUrl,
    Constants.authClientId,
    Constants.authRedirectUrl,
    Constants.authUrl,
    const FlutterSecureStorage(),
  );

  ref.onDispose(() => auth.dispose());

  return auth;
});

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

final authChangedProvider = StreamProvider<AuthState>((ref) {
  if (kDebugMode) HttpOverrides.global = DevHttpOverrides();
  return ref.watch(authProvider).authStateChanged;
});
