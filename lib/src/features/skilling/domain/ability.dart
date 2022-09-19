import 'package:json_annotation/json_annotation.dart';

part 'ability.g.dart';

@JsonSerializable()
class Ability {
  String name;
  bool isPassive;
  String description;

  Ability({
    required this.name,
    required this.description,
    required this.isPassive,
  });

  factory Ability.fromJson(Map<String, dynamic> json) => _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}
