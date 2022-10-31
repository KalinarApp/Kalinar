import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/group_management/data/user_repository.dart';

class HasGroupController with ChangeNotifier {
  final UserRepository _repo;

  bool? hasGroup;

  HasGroupController(this._repo);

  void check() {
    _repo.getUser().then((value) {
      hasGroup = null != value.group;
      notifyListeners();
    });
  }
}

final hasGroupProvider = ChangeNotifierProvider<HasGroupController>((ref) {
  return HasGroupController(ref.read(userRepositoryProvider));
});
