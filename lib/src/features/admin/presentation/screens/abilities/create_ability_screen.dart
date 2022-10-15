import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/presentation/controllers/ability_controller.dart';
import 'package:hero/src/utilities/async_value_extension.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../common_widgets/save_button.dart';

class CreateAbilityScreen extends ConsumerStatefulWidget {
  static const String name = "CreateAbility";
  static const route = "create";

  const CreateAbilityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateAbilityScreenState();
}

class _CreateAbilityScreenState extends ConsumerState<CreateAbilityScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  final saveController = RoundedLoadingButtonController();
  late AbilityController controller;

  @override
  void initState() {
    controller = ref.read(abilityControllerProvider);
    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        await controller.create(data).then((value) {
          value.showSnackbarOnError(context);
          if (value.hasError) {
            saveController.error();
          } else {
            saveController.success();
            GoRouter.of(context).pop();
          }
        });
      } else {
        saveController.error();
      }
    } else {
      saveController.error();
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
                  initialValue: "",
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.required(),
                  onChanged: (value) => saveController.reset(),
                  decoration: const InputDecoration(labelText: "Ability name", prefixIcon: SizedBox(width: 20)),
                ),
                FormBuilderSwitch(
                  name: "isPassive",
                  initialValue: false,
                  title: Text("Is passive ability?", style: Theme.of(context).textTheme.titleMedium),
                  onChanged: (value) => saveController.reset(),
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.gps_not_fixed_outlined)),
                ),
                FormBuilderTextField(
                  name: "description",
                  initialValue: "",
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
