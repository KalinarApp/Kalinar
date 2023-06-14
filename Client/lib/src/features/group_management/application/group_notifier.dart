import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/group.dart';

class GroupNotifier extends ChangeNotifier {
  static const groupKey = "currentGroup";

  Group? group;
  String? groupId;

  GroupNotifier() {
    _init();
  }

  void _init() async {
    final prefs = await SharedPreferences.getInstance();
    final currentGroup = prefs.getString(groupKey);
    groupId = currentGroup;
    notifyListeners();
  }

  Future<void> updateGroup(String? value) async {
    groupId = value;
    notifyListeners();

    if (null != value) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(groupKey, value);
    }
  }
}

final groupNotifierProvider = ChangeNotifierProvider<GroupNotifier>((ref) => GroupNotifier());
