import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../common_widgets/form_fields/bool_field.dart';
import '../../../../../../common_widgets/form_fields/description_field.dart';
import '../../../../../../common_widgets/form_fields/invisible_field.dart';
import '../../../../../../common_widgets/form_fields/name_field.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../common_widgets/save_button.dart';
import '../../../../../../utilities/async_value_extension.dart';
import '../../../application/ability_controller.dart';
import '../../../application/ability_list_controller.dart';
import '../../../domain/ability.dart';

class EditAbilityScreen extends ConsumerStatefulWidget {
  static const String name = "EditAbility";
  static const route = "ability";

  final String? abilityId;

  const EditAbilityScreen(this.abilityId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditAbilityScreenState();
}

class _EditAbilityScreenState extends ConsumerState<EditAbilityScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  late final Ability? item;

  final saveController = RoundedLoadingButtonController();
  late AbilityController controller;

  @override
  void initState() {
    controller = ref.read(abilityControllerProvider);
    item = null != widget.abilityId ? ref.read(abilityListControllerProvider).value!.firstWhere((element) => element.id == widget.abilityId) : null;

    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.abilityId ? await controller.create(data) : await controller.update(widget.abilityId!, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (value.hasError) {
          saveController.error();
          Future.delayed(const Duration(seconds: 3), saveController.reset);
        } else {
          saveController.success();
          GoRouter.of(context).pop();
        }
      } else {
        saveController.error();
        Future.delayed(const Duration(seconds: 3), saveController.reset);
      }
    } else {
      saveController.error();
      Future.delayed(const Duration(seconds: 3), saveController.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .95,
      width: MediaQuery.of(context).size.width * .4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SaveButton(controller: saveController, onSave: _save),
            ),
          ],
        ),
        body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  const InvisibleField(name: "id"),
                  NameField(label: AppLocalizations.of(context)!.abilityName, initialValue: item?.name),
                  BoolField(name: "isPassive", initialValue: item?.isPassive ?? false, label: AppLocalizations.of(context)!.abilityIsPasive),
                  DescriptionField(label: AppLocalizations.of(context)!.abilityDescription, initialValue: item?.description),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
