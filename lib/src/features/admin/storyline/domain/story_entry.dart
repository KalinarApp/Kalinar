import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kalinar/src/features/admin/storyline/domain/book_page.dart';

part 'story_entry.freezed.dart';
part 'story_entry.g.dart';

@freezed
class StoryEntry with _$StoryEntry {
  const factory StoryEntry({
    required String id,
    required String title,
    required int order,
    required String type,
    String? description,
    String? date,
    String? imageUrl,
    @Default([]) List<BookPage> pages,
    @Default(false) bool isUnlocked,
  }) = _StoryEntry;

  factory StoryEntry.fromJson(Map<String, dynamic> json) => _$StoryEntryFromJson(json);
}
