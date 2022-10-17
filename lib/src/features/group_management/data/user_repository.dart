import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/utilities/base_repository.dart';

import '../../../utilities/constants.dart';
import '../../authentication/data/auth_repository.dart';
import '../domain/user.dart';

class UserRepository extends BaseRepository {
  UserRepository(FlutterAuth auth) : super(auth);

  Future<User> getUser() {
    final url = Uri.https(Constants.baseUrl, "/api/users");
    return get(url, (response) => User.fromJson(response));
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.read(authProvider));
});
