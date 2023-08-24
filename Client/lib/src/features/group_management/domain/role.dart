import 'package:freezed_annotation/freezed_annotation.dart';

enum Role {
  @JsonValue("Owner")
  owner,
  @JsonValue("Administrator")
  administrator,
  @JsonValue("Member")
  member,
}

extension RoleExtensions on Role? {
  bool get isAdminRole => this != null && [Role.owner, Role.administrator].contains(this);
}
