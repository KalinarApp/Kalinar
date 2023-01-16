import 'package:freezed_annotation/freezed_annotation.dart';

import '../../admin/storyline/domain/story_entry_overview.dart';

part 'story_state.freezed.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState({
    @Default([]) List<StoryEntryOverview> images,
    @Default([]) List<StoryEntryOverview> books,
    @Default([]) List<StoryEntryOverview> history,
  }) = _StoryState;
}
