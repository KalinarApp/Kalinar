import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/group_management/application/group_notifier.dart';
import 'package:kalinar/src/features/traits/domain/suggestion_state.dart';
import 'package:kalinar/src/features/traits/presentation/components/edit_view.dart';

import '../../../common_widgets/form_fields/bool_field.dart';
import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../application/controller/abilities_controller.dart';
import '../application/notifier/ability_state_notifier.dart';
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
  bool _isCreatorOrAdminOrNew(Ability? item) {
    return widget.abilityId == null ||
        _isAdmin() ||
        (null != item && item.creator.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  @override
  Widget build(BuildContext context) {
    final state = null == widget.abilityId ? null : ref.watch(abilityStateNotifierProvider);

    return EditView(
      state,
      controller: ref.read(abilitiesControllerProvider),
      children: [
        const InvisibleField(name: "id"),
        NameField(
          label: AppLocalizations.of(context)!.abilityName,
          isLoading: state?.isLoading ?? false,
          initialValue: state?.valueOrNull?.name,
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
          initialValue: state?.valueOrNull?.description,
          readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
        ),
      ],
    );
  }
}
