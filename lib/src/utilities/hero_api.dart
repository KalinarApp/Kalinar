import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

final flutterAuthProvider = ChangeNotifierProvider<FlutterAuth>((ref) {
  return FlutterAuth.initialize(
    "https://auth.curth.dev/realms/kotd",
    "hero",
    "hero://login-callback",
    "https://auth.curth.dev/realms/kotd",
    const FlutterSecureStorage(),
  );
});

final heroApiProvider = Provider<HeroApi>((ref) {
  return HeroApi(authClient: ref.watch(flutterAuthProvider));
});
