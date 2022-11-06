import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/save_button.dart';
import '../../../../utilities/async_value_extension.dart';
import '../application/ability_controller.dart';
import '../application/ability_list_controller.dart';
import '../domain/ability.dart';

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
            child: Column(
              children: [
                FormBuilderTextField(
                  name: "name",
                  initialValue: item?.name,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.required(),
                  onChanged: (value) => saveController.reset(),
                  decoration: const InputDecoration(labelText: "Ability name", prefixIcon: SizedBox(width: 20)),
                ),
                FormBuilderSwitch(
                  name: "isPassive",
                  initialValue: item?.isPassive ?? false,
                  title: Text("Is passive ability?", style: Theme.of(context).textTheme.titleMedium),
                  onChanged: (value) => saveController.reset(),
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.gps_not_fixed_outlined)),
                ),
                FormBuilderTextField(
                  name: "description",
                  initialValue: item?.description,
                  maxLines: 4,
                  onChanged: (value) => saveController.reset(),
                  decoration: const InputDecoration(
                    label: Text("Ability description"),
                    alignLabelWithHint: true,
                    prefixIconConstraints: BoxConstraints.expand(width: 48, height: 100),
                    prefixIcon: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Icon(Icons.description),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
