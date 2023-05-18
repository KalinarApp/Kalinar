import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/layout/size.dart';
import '../../../../common_widgets/loading_indicator.dart';
import '../../domain/character.dart';
import 'big_character_sheet.dart';
import 'medium_character_sheet.dart';

class DesktopCharacterScreen extends ConsumerStatefulWidget {
  final Character? item;

  const DesktopCharacterScreen(this.item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DesktopCharacterScreenState();
}

class _DesktopCharacterScreenState extends ConsumerState<DesktopCharacterScreen> {
  @override
  Widget build(BuildContext context) {
    if (null == widget.item) {
      return LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter);
    }

    final item = widget.item!;

    return LayoutBuilder(builder: (ctx, constraints) {
      if (constraints.maxWidth < mobileMaxWidth) {
        return MediumCharacterSheet(item);
      } else {
        return BigCharacterSheet(item);
      }
    });
  }
}
