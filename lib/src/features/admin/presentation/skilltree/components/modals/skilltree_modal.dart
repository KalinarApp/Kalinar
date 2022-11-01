import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/form_fields/content_field.dart';
import 'package:hero/src/common_widgets/form_fields/value_range_field.dart';
import 'package:hero/src/features/admin/application/skilltree_controller.dart';
import 'package:hero/src/utilities/async_value_extension.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../../common_widgets/save_button.dart';

class SkilltreeModal extends ConsumerStatefulWidget {
  const SkilltreeModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkilltreeModalState();
}

class _SkilltreeModalState extends ConsumerState<SkilltreeModal> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  Future<void> _save(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        ref.read(skilltreeControllerProvider.notifier).createOnServer(data).then((value) {
          if (!mounted) return;
          value.showSnackbarOnError(context);
          if (value.hasError) {
            controller.error();
            Future.delayed(const Duration(seconds: 3), controller.reset);
          } else {
            controller.success();
            GoRouter.of(context).pop();
          }
        });
      } else {
        controller.error();
        Future.delayed(const Duration(seconds: 3), controller.reset);
      }
    } else {
      controller.error();
      Future.delayed(const Duration(seconds: 3), controller.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      color: Theme.of(context).dialogBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom + 12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  SaveButton(controller: controller, onSave: () => _save(ref, context)),
                ],
              ),
              ContentField("name", label: "Name", validators: FormBuilderValidators.required()),
              const ValueRangeField(name: "points", label: "Initiale Skillpunkte", initialValue: 0, min: 0, max: 10000, step: 1),
            ],
          ),
        ),
      ),
    );
  }
}
