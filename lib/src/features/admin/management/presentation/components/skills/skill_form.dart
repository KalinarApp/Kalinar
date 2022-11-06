import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../common_widgets/form_fields/description_field.dart';
import '../../../../../../common_widgets/form_fields/image_field.dart';
import '../../../../../../common_widgets/form_fields/value_range_field.dart';
import '../../../domain/skill.dart';
import 'ability_selection_field.dart';

class SkillForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final Skill? item;

  const SkillForm(this._formKey, {this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageField(initialValue: item?.iconUrl),
            DescriptionField(initialValue: item?.description),
            AbilitySelectionField(initialValue: item?.ability),
            const SizedBox(height: 10),
            ValueRangeField(name: "healthPointsBoost", label: "HP Boost", initialValue: item?.healthPointsBoost ?? 0, min: -100, max: 100, step: 1),
            ValueRangeField(name: "lightPointsBoost", label: "LP Boost", initialValue: item?.lightPointsBoost ?? 0, min: -10, max: 10, step: .5),
            ValueRangeField(
                name: "movementSpeedBoost", label: "Movement Boost", initialValue: item?.movementSpeedBoost ?? 0.0, min: -10.0, max: 10.0, step: .5),
            ValueRangeField(
                name: "resistenceBoost", label: "Resistance Boost", initialValue: item?.resistenceBoost ?? 0.0, min: -10.0, max: 10.0, step: .5),
            ValueRangeField(
                name: "opticalRangeBoost",
                label: "Optical Range Boost",
                initialValue: item?.opticalRangeBoost ?? 0.0,
                min: -10.0,
                max: 10.0,
                step: .5),
            ValueRangeField(
              name: "meleeDamageBoost",
              label: "Melee Damage Boost",
              initialValue: item?.meleeDamageBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
            ),
            ValueRangeField(
              name: "rangeDamageBoost",
              label: "Range Damage Boost",
              initialValue: item?.rangeDamageBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
            ),
            ValueRangeField(
              name: "lightDamageBoost",
              label: "Light Damage Boost",
              initialValue: item?.lightDamageBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
            ),
            ValueRangeField(
              name: "damageBoost",
              label: "Damage Boost",
              initialValue: item?.damageBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
            ),
            ValueRangeField(
              name: "parryBoost",
              label: "Parry Boost",
              initialValue: item?.parryBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
            ),
            ValueRangeField(
              name: "dodgeBoost",
              label: "Dodge Boost",
              initialValue: item?.dodgeBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
            ),
          ],
        ),
      ),
    );
  }
}
