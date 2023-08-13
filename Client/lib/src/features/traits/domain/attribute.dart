import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../utils/global_attributes.dart';
import '../../group_management/domain/user.dart';
import 'suggestable.dart';
import 'suggestion_state.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

@freezed
class Attribute with _$Attribute implements Suggestable {
  const factory Attribute({
    required String id,
    required String name,
    String? description,
    String? category,
    String? iconData,
    @Default(1) double stepSize,
    @Default(0) double minValue,
    @Default(10) double maxValue,
    @Default(false) bool isGlobal,
    required User? creator,
    required SuggestionState state,
    String? rejectionReason,
    required DateTime createdAt,
    DateTime? lastUpdatedAt,
    DateTime? approvedAt,
    DateTime? rejectedAt,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}

extension AttributeExtension on Attribute {
  Attribute translate(BuildContext context) {
    switch (id.toLowerCase()) {
      case GlobalAttribute.health:
        return copyWith(name: AppLocalizations.of(context)!.attributeHealth, description: AppLocalizations.of(context)!.attributeHealthDescription);
      case GlobalAttribute.parry:
        return copyWith(name: AppLocalizations.of(context)!.attributeParry, description: AppLocalizations.of(context)!.attributeParryDescription);
      case GlobalAttribute.dodge:
        return copyWith(name: AppLocalizations.of(context)!.attributeDodge, description: AppLocalizations.of(context)!.attributeDodgeDescription);
      case GlobalAttribute.motionRange:
        return copyWith(
            name: AppLocalizations.of(context)!.attributeMotionRange, description: AppLocalizations.of(context)!.attributeMotionRangeDescription);
      case GlobalAttribute.initiative:
        return copyWith(
            name: AppLocalizations.of(context)!.attributeInitiative, description: AppLocalizations.of(context)!.attributeInitiativeDescription);
      default:
        return this;
    }
  }
}
