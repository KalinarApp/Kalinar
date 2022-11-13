import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utilities/global_attributes.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

@freezed
class Attribute with _$Attribute {
  const factory Attribute({
    required String id,
    required String name,
    String? description,
    String? iconData,
    @Default(1) double stepSize,
    @Default(0) double minValue,
    @Default(10) double maxValue,
    @Default(false) bool isGlobal,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}

extension AttributeExtension on Attribute {
  Attribute translate(BuildContext context) {
    switch (id.toLowerCase()) {
      case GlobalAttribute.heart:
        return copyWith(name: AppLocalizations.of(context)!.attributeHealth, description: AppLocalizations.of(context)!.attributeHealthDescription);
      default:
        return this;
    }
  }
}
