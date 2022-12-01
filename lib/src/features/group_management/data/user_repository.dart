import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/base_repository.dart';
import '../../authentication/data/auth_repository.dart';
import '../domain/user.dart';

class UserRepository extends HeroBaseRepository {
  UserRepository(super.client);

  Future<User> getUser() {
    return heroGet("/api/users", (response) => User.fromJson(response));
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(authProvider));
});
