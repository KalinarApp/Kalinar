import 'package:freezed_annotation/freezed_annotation.dart';

import 'attribute_value.dart';

part 'race.freezed.dart';
part 'race.g.dart';

@freezed
class Race with _$Race {
  const factory Race({
    required String id,
    required String name,
    String? description,
    @Default([]) List<AttributeValue> attributes,
  }) = _Race;

  factory Race.fromJson(Map<String, dynamic> json) => _$RaceFromJson(json);
}
