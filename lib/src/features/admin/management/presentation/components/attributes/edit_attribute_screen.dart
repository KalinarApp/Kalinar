import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/form_fields/description_field.dart';
import 'package:hero/src/common_widgets/form_fields/icon_picker_field.dart';
import 'package:hero/src/features/admin/management/application/attribute_controller.dart';
import 'package:hero/src/features/admin/management/application/attribute_list_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/attribute.dart';
import '../../../../../../common_widgets/form_fields/name_field.dart';
import '../../../../../../common_widgets/save_button.dart';
import '../../../../../../utilities/async_value_extension.dart';

class EditAttributeScreen extends ConsumerStatefulWidget {
  static const name = "EditAttribute";
  static const route = "attribute/edit";

  final String? attributeId;

  const EditAttributeScreen(this.attributeId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditSkillScreenState();
}

class _EditSkillScreenState extends ConsumerState<EditAttributeScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  Attribute? item;

  late AttributeController controller;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    controller = ref.read(attributeControllerProvider);
    if (null != widget.attributeId) {
      item = ref.read(attributeListControllerProvider).valueOrNull?.firstWhere((element) => element.id == widget.attributeId);
    }

    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.attributeId ? await controller.create(data) : await controller.update(widget.attributeId!, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (value.hasError) {
          _btnController.error();
          Future.delayed(const Duration(seconds: 3), _btnController.reset);
        } else {
          _btnController.success();
          GoRouter.of(context).pop();
        }
      } else {
        _btnController.error();
        Future.delayed(const Duration(seconds: 3), _btnController.reset);
      }
    } else {
      _btnController.error();
      Future.delayed(const Duration(seconds: 3), _btnController.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SaveButton(controller: _btnController, onSave: _save),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                NameField(
                  label: AppLocalizations.of(context)!.attributeName,
                  initialValue: item?.name,
                  icon: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconPickerField(initialValue: item?.iconData),
                  ),
                ),
                DescriptionField(label: AppLocalizations.of(context)!.attributeDescription, initialValue: item?.description),
                FormBuilderTextField(
                  name: "stepSize",
                  initialValue: (item?.stepSize ?? 1).toString(),
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeStepSize),
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                ),
                FormBuilderTextField(
                  name: "minValue",
                  initialValue: (item?.minValue ?? 0).toString(),
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeMinValue),
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                ),
                FormBuilderTextField(
                  name: "maxValue",
                  initialValue: (item?.maxValue ?? 10).toString(),
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeMaxValue),
                  keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}