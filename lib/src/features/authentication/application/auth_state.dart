import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/user_info.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    bool? isAuthenticated,
    UserInfo? user,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);
}
