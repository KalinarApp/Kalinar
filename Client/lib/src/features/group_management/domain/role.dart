import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum Role {
  @JsonValue("Owner")
  owner,
  @JsonValue("Administrator")
  administrator,
  @JsonValue("Member")
  member,
}

extension RoleNullableExtensions on Role? {
  bool get isAdminRole => this != null && [Role.owner, Role.administrator].contains(this);
}

extension RoleExtensions on Role {
  String getLocalization(BuildContext context) {
    switch (this) {
      case Role.owner:
        return AppLocalizations.of(context)!.roleOwner;
      case Role.administrator:
        return AppLocalizations.of(context)!.roleAdministrator;
      case Role.member:
        return AppLocalizations.of(context)!.roleMember;
    }
  }
}
