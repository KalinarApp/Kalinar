import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_page.freezed.dart';
part 'book_page.g.dart';

@freezed
class BookPage with _$BookPage {
  const factory BookPage({
    required String id,
    required String bookId,
    required String title,
    required int pageNumber,
    required String content,
    @Default(false) bool isWritten,
  }) = _BookPage;

  factory BookPage.fromJson(Map<String, dynamic> json) => _$BookPageFromJson(json);
}
