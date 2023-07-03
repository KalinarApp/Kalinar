import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../group_management/domain/user.dart';

class UserNotifier extends ChangeNotifier {
  User? user;

  Future<void> updateGroup(User? value) async {
    user = value;
    notifyListeners();
  }
}

final userNotifierProvider = ChangeNotifierProvider<UserNotifier>((ref) => UserNotifier());
