import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences_helper.g.dart';

class SharedPreferencesHelper {
  final SharedPreferences preferences;
  SharedPreferencesHelper(this.preferences);

  String? getString(String key) => preferences.getString(key);
  void setString(String key, String value) => preferences.setString(key, value);
}

@Riverpod(keepAlive: true)
SharedPreferencesHelper getSharedPreferences(GetSharedPreferencesRef ref) {
  throw UnimplementedError();
}
