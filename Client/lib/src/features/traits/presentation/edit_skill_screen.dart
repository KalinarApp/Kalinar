import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/image_picker_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../application/controller/abilities_controller.dart';
import '../application/controller/skills_controller.dart';
import '../application/notifier/skill_state_notifier.dart';
import '../domain/skill.dart';
import '../domain/suggestion_state.dart';
import 'components/ability_selection_field.dart';
import 'components/attributes_field.dart';
import 'components/edit_view.dart';
import 'edit_ability_screen.dart';

class EditSkillScreen extends ConsumerStatefulWidget {
  static const String name = "EditSkill";
  static const route = "skills";

  final String? skillId;

  const EditSkillScreen(this.skillId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditSkillScreenState();
}

class _EditSkillScreenState extends ConsumerState<EditSkillScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  String? selectedAbilityId;

  bool _isCreatorOrAdminOrNew(Skill? item) {
    return widget.skillId == null ||
        _isAdmin() ||
        (null != item?.creator && item!.creator!.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(skillStateNotifierProvider, (previous, next) {
      if (null == previous || previous.isLoading) {
        _formKey.currentState?.fields["iconUrl"]?.didChange(next.valueOrNull?.iconUrl);
        _formKey.currentState?.fields["abilityId"]?.didChange(next.valueOrNull?.ability);
        _formKey.currentState?.fields["attributes"]?.didChange(next.valueOrNull?.attributes);
      }
    });
    final state = null == widget.skillId ? null : ref.watch(skillStateNotifierProvider);
    final iconUrl = state?.valueOrNull?.iconUrl;

    return EditView(
      state,
      formKey: _formKey,
      controller: ref.read(skillsControllerProvider),
      errorWidget: Center(child: Text(AppLocalizations.of(context)!.loadSkillFailed)),
      children: [
        const InvisibleField(name: "id"),
        ImagePickerField(initialValue: iconUrl),
        const SizedBox(height: 20),
        NameField(
            label: AppLocalizations.of(context)!.skillName,
            isLoading: state?.isLoading ?? false,
            initialValue: state?.valueOrNull?.name,
            readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull)),
        DescriptionField(
            label: AppLocalizations.of(context)!.skillDescription,
            isLoading: state?.isLoading ?? false,
            initialValue: state?.valueOrNull?.description,
            readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull)),
        AbilitySelectionField(initialValue: state?.valueOrNull?.ability, onSelectionChanged: (item) => setState(() => selectedAbilityId = item?.id)),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
              onPressed: null != selectedAbilityId
                  ? () {
                      ref.read(abilitiesControllerProvider).getById(selectedAbilityId!);
                      GoRouter.of(context).pushNamed(EditAbilityScreen.name, queryParameters: {"id": selectedAbilityId});
                    }
                  : null,
              child: Text(AppLocalizations.of(context)!.viewSelectedAbility)),
        ),
        const SizedBox(height: 30),
        AttributesField(initialValue: state?.valueOrNull?.attributes),
      ],
    );
  }
}
