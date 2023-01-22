import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_entry_overview.freezed.dart';
part 'story_entry_overview.g.dart';

@freezed
class StoryEntryOverview with _$StoryEntryOverview {
  const factory StoryEntryOverview({
    required String id,
    required String title,
    required int order,
    required String type,
    String? date,
    String? imageUrl,
    int? pageCount,
    String? description,
    @Default(false) bool isUnlocked,
  }) = _StoryEntryOverview;

  factory StoryEntryOverview.fromJson(Map<String, dynamic> json) => _$StoryEntryOverviewFromJson(json);
}
