import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/image_picker_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../../group_management/application/group_notifier.dart';
import '../application/controller/skills_controller.dart';
import '../application/notifier/skill_state_notifier.dart';
import '../domain/skill.dart';
import '../domain/suggestion_state.dart';
import 'components/edit_view.dart';

class EditSkillScreen extends ConsumerStatefulWidget {
  static const String name = "EditSkill";
  static const route = "skills";

  final String? skillId;

  const EditSkillScreen(this.skillId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditSkillScreenState();
}

class _EditSkillScreenState extends ConsumerState<EditSkillScreen> {
  bool _isCreatorOrAdminOrNew(Skill? item) {
    return widget.skillId == null ||
        _isAdmin() ||
        (null != item && item.creator.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  @override
  Widget build(BuildContext context) {
    final state = null == widget.skillId ? null : ref.watch(skillStateNotifierProvider);
    final iconUrl = state?.valueOrNull?.iconUrl;

    return EditView(
      state,
      controller: ref.read(skillsControllerProvider),
      children: [
        const InvisibleField(name: "id"),
        NameField(
            label: AppLocalizations.of(context)!.skillName,
            isLoading: state?.isLoading ?? false,
            initialValue: state?.valueOrNull?.name,
            readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull)),
        ImagePickerField(initialValue: iconUrl),
        DescriptionField(
            label: AppLocalizations.of(context)!.skillDescription,
            isLoading: state?.isLoading ?? false,
            initialValue: state?.valueOrNull?.description,
            readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull)),
      ],
    );
  }
}
