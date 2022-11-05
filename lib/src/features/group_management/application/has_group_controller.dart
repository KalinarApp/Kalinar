import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/data/user_repository.dart';

import '../domain/user.dart';

class HasGroupController with ChangeNotifier {
  final UserRepository _repo;

  bool? hasGroup;
  String? groupId;

  HasGroupController(this._repo);

  Future<void> check() async {
    User user = await _repo.getUser();
    groupId = user.group?.id;
    hasGroup = null != user.group;
    notifyListeners();
  }
}

final hasGroupProvider = ChangeNotifierProvider<HasGroupController>((ref) {
  return HasGroupController(ref.read(userRepositoryProvider));
});
