import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/form_fields/bool_field.dart';
import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../../../utils/http/async_value_extension.dart';
import '../application/controller/abilities_controller.dart';
import '../application/notifier/ability_state_notifier.dart';
import '../domain/ability.dart';
import '../domain/suggestion_state.dart';
import 'components/ability_tags_field.dart';
import 'components/edit_view.dart';

class EditAbilityScreen extends ConsumerStatefulWidget {
  static const String name = "EditAbility";
  static const route = "ability";

  final String? abilityId;

  const EditAbilityScreen(this.abilityId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditAbilityScreenState();
}

class _EditAbilityScreenState extends ConsumerState<EditAbilityScreen> {
  bool loadingFinished = false;

  static final _formKey = GlobalKey<FormBuilderState>();

  bool _isCreatorOrAdminOrNew(Ability? item) {
    return widget.abilityId == null ||
        _isAdmin() ||
        (null != item?.creator && item!.creator!.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    // return FirebaseAuth.instance.currentUser?.uid == ref.read(userNotifierProvider).user?.ownedGroup?.ownerId;
    return false;
  }

  Future _updateTags(List<String>? tags) async {
    if (null != widget.abilityId && loadingFinished) {
      final value = await ref.read(abilitiesControllerProvider).updateTags(widget.abilityId!, tags ?? []);
      if (!mounted) return;

      value.showNotification(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(abilityStateNotifierProvider, (previous, next) {
      if (null == previous || previous.isLoading) {
        _formKey.currentState?.fields["tags"]?.didChange(next.valueOrNull?.tags);
      }
      setState(() => loadingFinished = true);
    });

    final state = null == widget.abilityId ? null : ref.watch(abilityStateNotifierProvider);

    return EditView(
      state,
      formKey: _formKey,
      controller: ref.read(abilitiesControllerProvider),
      errorWidget: Center(child: Text(AppLocalizations.of(context)!.loadAbilityFailed)),
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
        AbilityTagsField(findSuggestion: ref.read(abilitiesControllerProvider).filterTags, onChanged: (tags) => _updateTags(tags)),
      ],
    );
  }
}
