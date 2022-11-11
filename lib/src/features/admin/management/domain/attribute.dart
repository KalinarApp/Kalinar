import 'package:freezed_annotation/freezed_annotation.dart';

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
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}
