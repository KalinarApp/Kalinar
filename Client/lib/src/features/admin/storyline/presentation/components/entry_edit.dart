import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../common_widgets/form_fields/bool_field.dart';
import '../../../../../common_widgets/form_fields/custom_text_field.dart';
import '../../../../../common_widgets/form_fields/multiline_text_field.dart';
import '../../domain/story_entry.dart';

class EntryEdit extends StatelessWidget {
  final StoryEntry? initialValue;
  final GlobalKey<FormBuilderState> formKey;

  const EntryEdit({required this.formKey, this.initialValue, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomtextField(
            name: "title",
            label: AppLocalizations.of(context)!.entryTitle,
            validator: FormBuilderValidators.required(),
            initialValue: initialValue?.title),
        MultilineTextField(
          name: "description",
          initialValue: initialValue?.description,
          label: AppLocalizations.of(context)!.entryDescription,
          maxLines: 6,
        ),
        CustomtextField(
          name: "date",
          label: AppLocalizations.of(context)!.entryDate,
          maxChararcters: 11,
          initialValue: initialValue?.date,
          helperText: AppLocalizations.of(context)!.entryDateHelp,
        ),
        BoolField(name: "isUnlocked", initialValue: initialValue?.isUnlocked, label: AppLocalizations.of(context)!.entryIsUnlocked),
      ],
    );
  }
}
