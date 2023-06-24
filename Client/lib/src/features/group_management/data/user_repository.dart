import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../domain/user.dart';

class UserRepository extends HeroBaseRepository {
  UserRepository();

  Future<User> getUser() async {
    return await heroGet("/api/users", (response) => User.fromJson(response));
  }

  Future updateDeviceId(String deviceId) async {
    await heroPost("/api/users/devices", {"deviceId": deviceId}, (response) => true);
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
