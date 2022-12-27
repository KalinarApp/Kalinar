import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../domain/user.dart';

class UserRepository extends HeroBaseRepository {
  Future<User> getUser() {
    return heroGet("/api/users", (response) => User.fromJson(response));
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});
