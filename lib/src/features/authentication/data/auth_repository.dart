import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_auth/models/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../utilities/base_repository.dart';
import '../../../utilities/constants.dart';

class AuthRepository extends HeroBaseRepository {
  AuthRepository(super.client);

  Future<void> _createUser() async {
    await heroPost("/api/users", null, (response) => true);
  }

  Future<bool> init() async {
    return await client.init();
  }

  Future<bool> login({String? username, String? password}) async {
    bool success = await client.login(username: username, password: password);
    if (success) {
      await _createUser();
    }
    return success;
  }

  Future<void> logout() async {
    await client.logout();
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
