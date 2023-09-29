import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

const String abilityNotApprovedException = "AbilityNotApprovedException";
const String abilityNotFoundException = "AbilityNotFoundException";
const String attributeNotApprovedException = "AttributeNotApprovedException";
const String attributeNotFoundException = "AttributeNotFoundException";
const String characterNotFoundException = "CharacterNotFoundException";
const String deviceIdAlreadyRegisteredException = "DeviceIdAlreadyRegisteredException";
const String forbiddenAccessException = "ForbiddenAccessException";
const String groupMemberNotFoundException = "GroupMemberNotFoundException";
const String groupNotFoundException = "GroupNotFoundException";
const String raceNotApprovedException = "RaceNotApprovedException";
const String raceNotFoundException = "RaceNotFoundException";
const String skillNotApprovedException = "SkillNotApprovedException";
const String skillNotFoundException = "SkillNotFoundException";
const String skilltreeEdgeAlreadyExistsException = "SkilltreeEdgeAlreadyExistsException";
const String skilltreeEdgeNotFoundException = "SkilltreeEdgeNotFoundException";
const String skilltreeNodeAlreadyUnlockedException = "SkilltreeNodeAlreadyUnlockedException";
const String skilltreeNodeNotFoundException = "SkilltreeNodeNotFoundException";
const String skilltreeNodeNotResetableException = "SkilltreeNodeNotResetableException";
const String skilltreeNodeNotUnlockableException = "SkilltreeNodeNotUnlockableException";
const String skilltreeNotEnoughPointsException = "SkilltreeNotEnoughPointsException";
const String skilltreeNotFoundException = "SkilltreeNotFoundException";
const String storyBookNotFoundException = "StoryBookNotFoundException";
const String storyBookPageNotFoundException = "StoryBookPageNotFoundException";
const String storyBookPageNumberAlreadyExistsException = "StoryBookPageNumberAlreadyExistsException";
const String storyEventNotFoundException = "StoryEventNotFoundException";
const String storyImageNotFoundException = "StoryImageNotFoundException";
const String userAlreadyExistsException = "UserAlreadyExistsException";
const String userAlreadyInGroupException = "UserAlreadyInGroupException";
const String userNotFoundException = "UserNotFoundException";

@freezed
class ErrorResponse with _$ErrorResponse {
  factory ErrorResponse(
    String type,
    List<String> errors,
  ) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
}

extension ErrorResponseExtensions on ErrorResponse {
  String getLocalizedMessage(BuildContext context) {
    switch (type) {
      case abilityNotApprovedException:
        return AppLocalizations.of(context)!.abilityNotApprovedException;
      case abilityNotFoundException:
        return AppLocalizations.of(context)!.abilityNotFoundException;
      case attributeNotApprovedException:
        return AppLocalizations.of(context)!.attributeNotApprovedException;
      case attributeNotFoundException:
        return AppLocalizations.of(context)!.attributeNotFoundException;
      case characterNotFoundException:
        return AppLocalizations.of(context)!.characterNotFoundException;
      case deviceIdAlreadyRegisteredException:
        return AppLocalizations.of(context)!.deviceIdAlreadyRegisteredException;
      case forbiddenAccessException:
        return AppLocalizations.of(context)!.forbiddenAccessException;
      case groupMemberNotFoundException:
        return AppLocalizations.of(context)!.groupMemberNotFoundException;
      case groupNotFoundException:
        return AppLocalizations.of(context)!.groupNotFoundException;
      case raceNotApprovedException:
        return AppLocalizations.of(context)!.raceNotApprovedException;
      case raceNotFoundException:
        return AppLocalizations.of(context)!.raceNotFoundException;
      case skillNotApprovedException:
        return AppLocalizations.of(context)!.skillNotApprovedException;
      case skillNotFoundException:
        return AppLocalizations.of(context)!.skillNotFoundException;
      case skilltreeEdgeAlreadyExistsException:
        return AppLocalizations.of(context)!.skilltreeEdgeAlreadyExistsException;
      case skilltreeEdgeNotFoundException:
        return AppLocalizations.of(context)!.skilltreeEdgeNotFoundException;
      case skilltreeNodeAlreadyUnlockedException:
        return AppLocalizations.of(context)!.skilltreeNodeAlreadyUnlockedException;
      case skilltreeNodeNotFoundException:
        return AppLocalizations.of(context)!.skilltreeNodeNotFoundException;
      case skilltreeNodeNotResetableException:
        return AppLocalizations.of(context)!.skilltreeNodeNotResetableException;
      case skilltreeNodeNotUnlockableException:
        return AppLocalizations.of(context)!.skilltreeNodeNotUnlockableException;
      case skilltreeNotEnoughPointsException:
        return AppLocalizations.of(context)!.skilltreeNotEnoughPointsException;
      case skilltreeNotFoundException:
        return AppLocalizations.of(context)!.skilltreeNotFoundException;
      case storyBookNotFoundException:
        return AppLocalizations.of(context)!.storyBookNotFoundException;
      case storyBookPageNotFoundException:
        return AppLocalizations.of(context)!.storyBookPageNotFoundException;
      case storyBookPageNumberAlreadyExistsException:
        return AppLocalizations.of(context)!.storyBookPageNumberAlreadyExistsException;
      case storyEventNotFoundException:
        return AppLocalizations.of(context)!.storyEventNotFoundException;
      case storyImageNotFoundException:
        return AppLocalizations.of(context)!.storyImageNotFoundException;
      case userAlreadyExistsException:
        return AppLocalizations.of(context)!.userAlreadyExistsException;
      case userAlreadyInGroupException:
        return AppLocalizations.of(context)!.userAlreadyInGroupException; 
      case userNotFoundException:
        return AppLocalizations.of(context)!.userNotFoundException;
      default:
        return AppLocalizations.of(context)!.errorUnknown;
    }
  }
}
