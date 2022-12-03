import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../../common_widgets/form_fields/attribute/attributes_field.dart';
import '../../../../../../common_widgets/form_fields/description_field.dart';
import '../../../../../../common_widgets/form_fields/name_field.dart';
import '../../../../../../common_widgets/save_button.dart';
import '../../../../../../utilities/async_value_extension.dart';
import '../../../application/race_controller.dart';
import '../../../application/race_list_controller.dart';
import '../../../domain/race.dart';

class EditRaceScreen extends ConsumerStatefulWidget {
  static const name = "EditRace";
  static const route = "race/edit";

  final String? raceId;

  const EditRaceScreen(this.raceId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditRaceScreenState();
}

class _EditRaceScreenState extends ConsumerState<EditRaceScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  Race? item;

  late RaceController controller;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    controller = ref.read(raceControllerProvider);
    if (null != widget.raceId) {
      item = ref.read(raceListControllerProvider).valueOrNull?.firstWhere((element) => element.id == widget.raceId);
    }

    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.raceId ? await controller.create(data) : await controller.update(widget.raceId!, data);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameField(label: AppLocalizations.of(context)!.raceName, initialValue: item?.name),
                DescriptionField(label: AppLocalizations.of(context)!.raceDescription, initialValue: item?.description),
                const SizedBox(height: 30),
                Text(AppLocalizations.of(context)!.raceAttributeSelection, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 10),
                AttributesField(initialValue: item?.attributes, alwaysShowGlobal: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
