import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';

class HeroRouterListenable extends ChangeNotifier {
  var _isLoggedIn = false;

  HeroRouterListenable(WidgetRef ref) {
    ref.watch(authChangedProvider).whenData((value) {
      _isLoggedIn = value.isAuthenticated ?? false;
      notifyListeners();
    });
  }

  bool get isLoggedIn => _isLoggedIn;
}
