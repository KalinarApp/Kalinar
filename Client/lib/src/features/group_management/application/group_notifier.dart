import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/group.dart';

class GroupNotifier extends ChangeNotifier {
  Group? group;
  bool? hasGroup;

  void updateGroup(Group? value) {
    hasGroup = null != value;
    group = value;
    notifyListeners();
  }
}

final groupNotifierProvider = ChangeNotifierProvider<GroupNotifier>((ref) => GroupNotifier());
