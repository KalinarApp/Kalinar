import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod/riverpod.dart';

class HeroApi {
  static const String _apiBaseUrl = "hero.jonascurth.de";
  static const String _apiPath = "/api";

  final FlutterAuth authClient;

  HeroApi({required this.authClient});

  Uri abilities(String? name) => _buildUri(endpoint: "/abilities${null != name ? "/$name}" : ""}", parametsersBuilder: () => {});

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametsersBuilder,
  }) {
    return Uri(scheme: "https", host: _apiBaseUrl, path: "$_apiPath$endpoint", queryParameters: parametsersBuilder());
  }
}

final heroApiProvider = Provider<HeroApi>((ref) {
  final authClient = FlutterAuth.initialize(
    "https://auth.curth.dev/realms/kotd",
    "hero-app",
    "hero://login-callback",
    "https://auth.curth.dev/realms/kotd",
    const FlutterSecureStorage(),
  );

  return HeroApi(authClient: authClient);
});
