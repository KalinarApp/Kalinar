import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({required bool isAuthenticated, User? user}) = _AuthState;
}
