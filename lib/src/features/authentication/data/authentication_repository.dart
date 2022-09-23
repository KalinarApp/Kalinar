import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_auth/models/user_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/hero_api.dart';

import '../domain/user.dart';

class AuthenticationRepository {
  final FlutterAuth authClient;

  AuthenticationRepository({required this.authClient});

  User _userInfoToUser(UserInfo userinfo) {
    return User(id: userinfo.id, email: userinfo.email, firstName: userinfo.firstName, lastName: userinfo.lastName);
  }

  Future<User?> login() async {
    User? user;
    final userinfo = await authClient.login();
    if (null != userinfo) user = _userInfoToUser(userinfo);
    return user;
  }

  Future<void> logout() async {
    return await authClient.logout();
  }
}

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository(authClient: ref.read(heroApiProvider).authClient);
});
