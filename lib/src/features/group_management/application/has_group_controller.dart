import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/flutter_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';
import 'package:hero/src/features/group_management/data/user_repository.dart';

import '../domain/user.dart';

class HasGroupController with ChangeNotifier {
  final UserRepository _repo;
  final FlutterAuth auth;

  bool? hasGroup;
  String? groupId;

  HasGroupController(this._repo, this.auth);

  Future<void> check() async {
    User user = await _repo.getUser();
    groupId = user.group?.id;
    hasGroup = null != user.group;
    await auth.init();

    notifyListeners();
  }
}

final hasGroupProvider = ChangeNotifierProvider<HasGroupController>((ref) {
  return HasGroupController(ref.read(userRepositoryProvider), ref.read(authProvider));
});
