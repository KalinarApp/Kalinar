import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kalinar/src/features/group_management/application/group_notifier.dart';
import 'package:kalinar/src/features/traits/domain/suggestion_state.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../common_widgets/form_fields/bool_field.dart';
import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../../../utilities/async_value_extension.dart';
import '../application/abilities_controller.dart';
import '../application/ability_state_notifier.dart';
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
  bool hasChanges = false;

  final saveController = RoundedLoadingButtonController();
  late AbilitiesController controller;

  @override
  void initState() {
    controller = ref.read(abilitiesControllerProvider);

    if (null != widget.abilityId) {
      Future.delayed(Duration.zero, () => controller.getAbilityById(widget.abilityId!));
    }

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

  bool _isCreatorOrAdminOrNew(Ability? item) {
    return widget.abilityId == null ||
        _isAdmin() ||
        (null != item && item.creator.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  String _getSaveButtonTitle(Ability? ability) {
    final isAdmin = _isAdmin();
    return isAdmin && ability?.state == SuggestionState.pending ? "Speichern & Genehmigen" : "Speichern";
  }

  Widget _buildContent(BuildContext context, AsyncValue<Ability>? state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const InvisibleField(name: "id"),
          NameField(
            label: AppLocalizations.of(context)!.abilityName,
            isLoading: state?.isLoading ?? false,
            initialValue: state?.value?.name,
            readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
          ),
          BoolField(
            name: "isPassive",
            label: AppLocalizations.of(context)!.abilityIsPasive,
            isLoading: state?.isLoading ?? false,
            initialValue: state?.value?.isPassive ?? false,
            readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
          ),
          DescriptionField(
            label: AppLocalizations.of(context)!.abilityDescription,
            isLoading: state?.isLoading ?? false,
            initialValue: state?.value?.description,
            readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: _isCreatorOrAdminOrNew(state?.valueOrNull) ? _save : null,
            child: SizedBox(
              width: double.infinity,
              child: Center(child: Text(_getSaveButtonTitle(state?.valueOrNull), style: Theme.of(context).textTheme.titleLarge)),
            ),
          ),
          if (_isAdmin())
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
              child: SizedBox(width: double.infinity, child: Center(child: Text("Ablehnen", style: Theme.of(context).textTheme.titleLarge))),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = null == widget.abilityId ? null : ref.watch(abilityStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(),
      body: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: null != state
              ? state.maybeWhen(
                  error: (error, stackTrace) => const Center(child: Text("Fehler beim Abrufen des gewünschten Talents.")),
                  orElse: () => _buildContent(context, state))
              : _buildContent(context, state),
        ),
      ),
    );

    // return SizedBox(
    //   height: MediaQuery.of(context).size.height * .95,
    //   width: MediaQuery.of(context).size.width * .4,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       actions: [
    //         Padding(
    //           padding: const EdgeInsets.only(right: 12.0),
    //           child: SaveButton(controller: saveController, onSave: _save),
    //         ),
    //       ],
    //     ),
    //     body: FormBuilder(
    //       key: _formKey,
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 12),
    //         child: SingleChildScrollView(
    //           child: Column(
    //             children: [
    //               const SizedBox(height: 12),
    //               const InvisibleField(name: "id"),
    //               NameField(label: AppLocalizations.of(context)!.abilityName, initialValue: item?.name),
    //               BoolField(name: "isPassive", initialValue: item?.isPassive ?? false, label: AppLocalizations.of(context)!.abilityIsPasive),
    //               DescriptionField(label: AppLocalizations.of(context)!.abilityDescription, initialValue: item?.description),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
