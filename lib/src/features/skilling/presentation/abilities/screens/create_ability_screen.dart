import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/skilling/presentation/abilities/controllers/create_ability_controller.dart';

import '../../../../../common_widgets/save_button.dart';
import '../components/ability_form.dart';

class CreateAbilityScreen extends ConsumerStatefulWidget {
  static const routeName = "ability/create";

  const CreateAbilityScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateAbilityScreenState();
}

class _CreateAbilityScreenState extends ConsumerState<CreateAbilityScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  late CreateAbilityController controller;

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
        controller.create(data);
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
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: AbilityForm(),
            )),
      ),
    );
  }
}
