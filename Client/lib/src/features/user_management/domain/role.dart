import 'package:freezed_annotation/freezed_annotation.dart';

enum Role {
  @JsonValue("Owner")
  owner,
  @JsonValue("Administrator")
  administrator,
  @JsonValue("Member")
  member,
}
