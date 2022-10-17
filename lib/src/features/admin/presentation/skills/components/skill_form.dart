import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/presentation/skills/components/ability_selection_field.dart';
import 'package:hero/src/features/admin/presentation/skills/components/description_field.dart';
import 'package:hero/src/features/admin/presentation/skills/components/image_field.dart';
import 'package:hero/src/features/admin/presentation/skills/components/value_range_field.dart';

import '../../../domain/skill.dart';

class SkillForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;
  final Skill? item;
  final Function() reset;

  const SkillForm(this._formKey, {required this.reset, this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageField(initialValue: item?.iconUrl, reset: reset),
            DescriptionField(initialValue: item?.description, reset: reset),
            AbilitySelectionField(initialValue: item?.ability, reset: reset),
            const SizedBox(height: 10),
            ValueRangeField(
              name: "healthPointsBoost",
              label: "HP Boost",
              initialValue: item?.healthPointsBoost ?? 0,
              min: -100,
              max: 100,
              step: 1,
              reset: reset,
            ),
            ValueRangeField(
              name: "lightPointsBoost",
              label: "LP Boost",
              initialValue: item?.lightPointsBoost ?? 0,
              min: -10,
              max: 10,
              step: .5,
              reset: reset,
            ),
            ValueRangeField(
                name: "movementSpeedBoost",
                label: "Movement Boost",
                initialValue: item?.movementSpeedBoost ?? 0.0,
                min: -10.0,
                max: 10.0,
                step: .5,
                reset: reset),
            ValueRangeField(
                name: "resistenceBoost",
                label: "Resistance Boost",
                initialValue: item?.resistenceBoost ?? 0.0,
                min: -10.0,
                max: 10.0,
                step: .5,
                reset: reset),
            ValueRangeField(
                name: "opticalRangeBoost",
                label: "Optical Range Boost",
                initialValue: item?.opticalRangeBoost ?? 0.0,
                min: -10.0,
                max: 10.0,
                step: .5,
                reset: reset),
            ValueRangeField(
                name: "meleeDamageBoost",
                label: "Melee Damage Boost",
                initialValue: item?.meleeDamageBoost ?? 0.0,
                min: -10.0,
                max: 10.0,
                step: .5,
                reset: reset),
            ValueRangeField(
                name: "rangeDamageBoost",
                label: "Range Damage Boost",
                initialValue: item?.rangeDamageBoost ?? 0.0,
                min: -10.0,
                max: 10.0,
                step: .5,
                reset: reset),
            ValueRangeField(
                name: "lightDamageBoost",
                label: "Light Damage Boost",
                initialValue: item?.lightDamageBoost ?? 0.0,
                min: -10.0,
                max: 10.0,
                step: .5,
                reset: reset),
            ValueRangeField(
              name: "damageBoost",
              label: "Damage Boost",
              initialValue: item?.damageBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
              reset: reset,
            ),
            ValueRangeField(
              name: "parryBoost",
              label: "Parry Boost",
              initialValue: item?.parryBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
              reset: reset,
            ),
            ValueRangeField(
              name: "dodgeBoost",
              label: "Dodge Boost",
              initialValue: item?.dodgeBoost ?? 0.0,
              min: -10.0,
              max: 10.0,
              step: .5,
              reset: reset,
            ),
          ],
        ),
      ),
    );
  }
}
