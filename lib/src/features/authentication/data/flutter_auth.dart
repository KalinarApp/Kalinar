import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../application/auth_state.dart';
import '../domain/user_info.dart';

class FlutterAuth {
  final String _domain;
  final String _clientId;
  final String _redirectUri;
  final String _issuer;

  Future<void>? _refreshProcess;

  final _authStateChangedController = BehaviorSubject<AuthState>.seeded(const AuthState());

  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _storage;

  String? _accessToken;
  DateTime? _tokenExpiryDate;

  FlutterAuth.initialize(this._domain, this._clientId, this._redirectUri, this._issuer, this._storage);

  Stream<AuthState> get authStateChanged => _authStateChangedController.stream;

  Future<String?> _getRefreshToken() async {
    return await _storage.read(key: 'refresh-token');
  }

  Future<UserInfo?> _getUserDetails(String accessToken) async {
    UserInfo? user;
    final url = Uri.parse("${Uri.parse(_domain)}/protocol/openid-connect/userinfo");
    final response = await http.get(url, headers: {"Authorization": "Bearer $accessToken"});
    if (200 == response.statusCode) {
      user = UserInfo.fromAccessToken(jsonDecode(response.body));
    }

    return user;
  }

  Future<void> _signInWithUsernamePassword({String? username, String? password, String? refreshToken}) async {
    final url = Uri.parse("${Uri.parse(_domain)}/protocol/openid-connect/token");

    final body = null != refreshToken
        ? {"refresh_token": refreshToken, "grant_type": "refresh_token", "client_id": _clientId}
        : {
            'username': username,
            "password": password,
            "grant_type": "password",
            "client_id": _clientId,
          };

    final response = await post(url, body: body, headers: {"Content-Type": "application/x-www-form-urlencoded"});
    if (200 == response.statusCode) {
      final data = json.decode(response.body);

      if (null != data && null != data["access_token"]) {
        await _storage.write(key: 'refresh-token', value: data["refresh_token"]);
        _accessToken = data["access_token"];
        _tokenExpiryDate = DateTime.now().add(Duration(seconds: data["expires_in"]));
        UserInfo? user = await _getUserDetails(data["access_token"]);

        _authStateChangedController.add(AuthState(isAuthenticated: true, user: user));
      }
    } else {
      throw Exception(["statuscode: ${response.statusCode}", response.body]);
    }
  }

  Future<void> _signInWithRedirect() async {
    final response = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _clientId,
        _redirectUri,
        issuer: _issuer,
        promptValues: ['login'],
        scopes: ['offline_access'],
      ),
    );

    if (null != response && null != response.accessToken) {
      await _storage.write(key: 'refresh-token', value: response.refreshToken);
      _accessToken = response.accessToken;
      _tokenExpiryDate = response.accessTokenExpirationDateTime;
      UserInfo? user = await _getUserDetails(response.accessToken!);

      _authStateChangedController.add(AuthState(isAuthenticated: true, user: user));
    }
  }

  Future<void> _refreshToken() async {
    final storedRefreshToken = await _getRefreshToken();
    if (null == storedRefreshToken) {
      _authStateChangedController.add(const AuthState(isAuthenticated: false));
      return;
    }

    try {
      if (Platform.isWindows) {
        await _signInWithUsernamePassword(refreshToken: storedRefreshToken);
      } else {
        final response = await _appAuth.token(TokenRequest(
          _clientId,
          _redirectUri,
          issuer: _issuer,
          refreshToken: storedRefreshToken,
        ));

        UserInfo? user;
        if (null != response && null != response.accessToken) {
          _accessToken = response.accessToken;
          _tokenExpiryDate = response.accessTokenExpirationDateTime;

          user = await _getUserDetails(response.accessToken!);
          _authStateChangedController.add(AuthState(isAuthenticated: true, user: user));
        }
      }
    } catch (ex, stackTrace) {
      await Sentry.captureException(ex, stackTrace: stackTrace);
      _authStateChangedController.add(const AuthState(isAuthenticated: false));

      await logout();
    }
  }

  Future<void> _initIfAccessTokenIsExpired() async {
    if (null == _refreshProcess) {
      if (null == _tokenExpiryDate || _tokenExpiryDate!.isBefore(DateTime.now())) {
        _refreshProcess = _refreshToken();
        _refreshProcess!.whenComplete(() => _refreshProcess = null);
        await _refreshProcess;
      }
    } else {
      _refreshProcess!.whenComplete(() async {
        if (null == _tokenExpiryDate || _tokenExpiryDate!.isBefore(DateTime.now())) {
          _refreshProcess = _refreshToken();
          _refreshProcess!.whenComplete(() => _refreshProcess = null);
          await _refreshProcess;
        }
      });
    }
  }

  Future<bool> init() async {
    await _initIfAccessTokenIsExpired();
    return null != _accessToken;
  }

  Future<void> openProfile() async {
    await _initIfAccessTokenIsExpired();
    if (!await launchUrl(Uri.parse("$_domain/account"),
        webViewConfiguration: WebViewConfiguration(headers: {"Authorization": "Bearer $_accessToken"}))) {
      throw 'Could not open profile.';
    }
  }

  Future<bool> login({String? username, String? password}) async {
    bool success = false;
    try {
      if (null != username && null != password) {
        await _signInWithUsernamePassword(username: username, password: password);
      } else {
        await _signInWithRedirect();
      }
      success = true;
    } catch (ex, stackTrace) {
      await Sentry.captureException(ex, stackTrace: stackTrace);
      _authStateChangedController.add(const AuthState(isAuthenticated: false));

      await logout();
    }

    return success;
  }

  Future<void> logout() async {
    _accessToken = _tokenExpiryDate = null;
    await _storage.delete(key: 'refresh-token');
    _authStateChangedController.add(const AuthState(isAuthenticated: false));
  }

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    await _initIfAccessTokenIsExpired();
    final localHeaders = {...headers ?? {}};
    localHeaders.update("Authorization", (_) => "Bearer $_accessToken", ifAbsent: () => "Bearer $_accessToken");
    return await http.get(url, headers: localHeaders);
  }

  Future<http.Response> post(Uri url, {Object? body, Map<String, String>? headers, Encoding? encoding}) async {
    await _initIfAccessTokenIsExpired();
    final localHeaders = {...headers ?? {}};
    localHeaders.update("Authorization", (_) => "Bearer $_accessToken", ifAbsent: () => "Bearer $_accessToken");
    return await http.post(url, body: body, headers: localHeaders, encoding: encoding);
  }

  Future<http.Response> delete(Uri url, {Object? body, Map<String, String>? headers, Encoding? encoding}) async {
    await _initIfAccessTokenIsExpired();
    final localHeaders = {...headers ?? {}};
    localHeaders.update("Authorization", (_) => "Bearer $_accessToken", ifAbsent: () => "Bearer $_accessToken");
    return await http.delete(url, body: body, headers: localHeaders, encoding: encoding);
  }

  Future<http.Response> patch(Uri url, {Object? body, Map<String, String>? headers, Encoding? encoding}) async {
    await _initIfAccessTokenIsExpired();
    final localHeaders = {...headers ?? {}};
    localHeaders.update("Authorization", (_) => "Bearer $_accessToken", ifAbsent: () => "Bearer $_accessToken");
    return await http.patch(url, body: body, headers: localHeaders, encoding: encoding);
  }

  Future<http.Response> put(Uri url, {Object? body, Map<String, String>? headers, Encoding? encoding}) async {
    await _initIfAccessTokenIsExpired();
    final localHeaders = {...headers ?? {}};
    localHeaders.update("Authorization", (_) => "Bearer $_accessToken", ifAbsent: () => "Bearer $_accessToken");
    return await http.put(url, body: body, headers: localHeaders, encoding: encoding);
  }

  void dispose() {
    _authStateChangedController.close();
  }
}
