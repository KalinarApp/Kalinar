import 'package:freezed_annotation/freezed_annotation.dart';

part 'blueprint_overview.freezed.dart';
part 'blueprint_overview.g.dart';

@freezed
class BlueprintOverview with _$BlueprintOverview {
  const factory BlueprintOverview({
    required String id,
    required String name,
    required int nodeCount,
  }) = _BlueprintOverview;

  factory BlueprintOverview.fromJson(Map<String, dynamic> json) => _$BlueprintOverviewFromJson(json);
}
