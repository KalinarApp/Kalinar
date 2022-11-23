import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../common_widgets/form_fields/selection_field.dart';
import '../../../admin/management/application/race_controller.dart';
import '../../../admin/management/domain/race.dart';

import 'attribute_value_widget.dart';

class RaceSelection extends ConsumerStatefulWidget {
  const RaceSelection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RaceSelectionState();
}

class _RaceSelectionState extends ConsumerState<RaceSelection> {
  Race? selectedRace;

  @override
  Widget build(BuildContext context) {
    final sortedAttributes = null != selectedRace ? [...selectedRace!.attributes] : null;
    sortedAttributes?.sort((a, b) => b.attribute.isGlobal ? 1 : -1);
    return Column(
      children: [
        const SizedBox(height: 10),
        if (null != selectedRace)
          GridView.builder(
            itemCount: sortedAttributes!.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100, childAspectRatio: 100 / 32),
            shrinkWrap: true,
            itemBuilder: (context, index) => AttributeValueWidget(sortedAttributes[index]),
          ),
        SelectionField<Race>(
          name: "raceId",
          validator: FormBuilderValidators.required(),
          transformer: (value) => value?.id,
          asString: (item) => item.name,
          compareFn: (item1, item2) => item1.name == item2.name,
          label: AppLocalizations.of(context)!.selectARace,
          searchLabel: AppLocalizations.of(context)!.searchForRace,
          icon: const Icon(FontAwesomeIcons.person),
          items: (_) async => await ref.read(raceControllerProvider).getAll(),
          onChanged: (previous, next) async {
            setState(() => selectedRace = next);
            return true;
          },
        ),
      ],
    );
  }
}
