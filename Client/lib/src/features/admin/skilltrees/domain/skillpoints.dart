import 'package:freezed_annotation/freezed_annotation.dart';

part 'skillpoints.freezed.dart';
part 'skillpoints.g.dart';

@freezed
class Skillpoints with _$Skillpoints {
  const factory Skillpoints({
    @Default(0) int currentSkillpoints,
    @Default(0) int maxSkillpoints,
    String? iconUrl,
  }) = _Skillpoints;

  factory Skillpoints.fromJson(Map<String, dynamic> json) => _$SkillpointsFromJson(json);
}
