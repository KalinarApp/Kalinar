import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/group.dart';

class GroupNotifier extends ChangeNotifier {
  static const groupKey = "currentGroup";

  Group? group;
  String? groupId;
  bool isInitialized = false;

  Future init() async {
    final prefs = await SharedPreferences.getInstance();
    final currentGroup = prefs.getString(groupKey);
    groupId = currentGroup;
    isInitialized = true;
    notifyListeners();
  }

  Future<void> updateGroup(String? value) async {
    groupId = value;

    if (null != value) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(groupKey, value);
    }

    notifyListeners();
  }
}

final groupNotifierProvider = ChangeNotifierProvider<GroupNotifier>((ref) => GroupNotifier());
