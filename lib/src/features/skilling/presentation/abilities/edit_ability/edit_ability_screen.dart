import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hero/src/features/skilling/presentation/abilities/create_ability_controller.dart';

import '../../../../../common_widgets/save_button.dart';
import '../../../domain/ability.dart';
import 'ability_form.dart';

class EditAbilityScreen extends ConsumerStatefulWidget {
  static const routeName = "ability/edit";

  const EditAbilityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditAbilityScreenState();
}

class _EditAbilityScreenState extends ConsumerState<EditAbilityScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  late CreateAbilityController controller;
  late Ability item;

  @override
  void didChangeDependencies() {
    item = ModalRoute.of(context)!.settings.arguments as Ability;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    controller = ref.read(createAbilityControllerProvider.notifier);
    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        controller.update(item.name, data).then((_) => Navigator.pop(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(createAbilityControllerProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * .95,
      width: MediaQuery.of(context).size.width * .4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SaveButton(controller: controller.buttonController, onSave: _save),
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
                  readOnly: true,
                  initialValue: item.name,
                  textInputAction: TextInputAction.next,
                  validator: FormBuilderValidators.required(),
                  decoration: const InputDecoration(labelText: "Ability name", prefixIcon: SizedBox(width: 20)),
                ),
                FormBuilderSwitch(
                  name: "isPassive",
                  initialValue: item.isPassive,
                  title: Text(
                    "Is passive ability?",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.gps_not_fixed_outlined)),
                ),
                FormBuilderTextField(
                  name: "description",
                  initialValue: item.description,
                  maxLines: 4,
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
