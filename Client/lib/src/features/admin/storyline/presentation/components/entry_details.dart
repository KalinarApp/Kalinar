import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/story_entry.dart';

class EntryDetails extends StatelessWidget {
  final StoryEntry item;

  const EntryDetails(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("${AppLocalizations.of(context)!.entryDate}: ", style: Theme.of(context).textTheme.bodyLarge),
                Text(item.date ?? "-"),
              ],
            ),
            const SizedBox(height: 12),
            Text("${AppLocalizations.of(context)!.entryDescription}:", style: Theme.of(context).textTheme.bodyLarge),
            Text(item.description ?? ""),
          ],
        ),
      ),
    );
  }
}
