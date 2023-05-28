import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/layout/size.dart';
import '../../../../common_widgets/loading_indicator.dart';
import '../../domain/character.dart';
import 'components/big_character_sheet.dart';
import 'components/small_character_sheet.dart';

class CharacterScreen extends ConsumerStatefulWidget {
  final Character? item;

  const CharacterScreen(this.item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends ConsumerState<CharacterScreen> {
  @override
  Widget build(BuildContext context) {
    if (null == widget.item) {
      return LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter);
    }

    final item = widget.item!;

    return LayoutBuilder(builder: (ctx, constraints) {
      if (constraints.maxWidth < tabletMaxWidth) {
        return SmallCharacterSheet(item);
      } else {
        return BigCharacterSheet(item);
      }
    });
  }
}
