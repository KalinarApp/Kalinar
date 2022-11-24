import 'package:freezed_annotation/freezed_annotation.dart';

import 'attribute.dart';

part 'attribute_value.freezed.dart';
part 'attribute_value.g.dart';

@freezed
class AttributeValue with _$AttributeValue {
  const factory AttributeValue({
    required String attributeId,
    required Attribute attribute,
    required double value,
    @Default(0) double currentValue,
  }) = _AttributeValue;

  factory AttributeValue.fromJson(Map<String, dynamic> json) => _$AttributeValueFromJson(json);
}

extension AttributeValueListExtension on List<AttributeValue> {
  void globalFirst() {
    sort((a, b) => b.attribute.isGlobal ? 1 : -1);
  }
}
