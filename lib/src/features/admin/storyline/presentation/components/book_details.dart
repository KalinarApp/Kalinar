import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/admin/storyline/domain/story_entry.dart';

class BookDetails extends ConsumerStatefulWidget {
  final StoryEntry item;
  const BookDetails(this.item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookDetailsState();
}

class _BookDetailsState extends ConsumerState<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
