import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/icon_picker_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../../group_management/application/group_notifier.dart';
import '../application/controller/attributes_controller.dart';
import '../application/notifier/attribute_state_notifier.dart';
import '../domain/attribute.dart';
import '../domain/suggestion_state.dart';
import 'components/edit_view.dart';

class EditAttributeScreen extends ConsumerStatefulWidget {
  static const String name = "EditAttribute";
  static const route = "attribute";

  final String? attributeId;

  const EditAttributeScreen(this.attributeId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditAttributeScreenState();
}

class _EditAttributeScreenState extends ConsumerState<EditAttributeScreen> {
  bool _isCreatorOrAdminOrNew(Attribute? item) {
    return widget.attributeId == null ||
        _isAdmin() ||
        (null != item && item.creator.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  @override
  Widget build(BuildContext context) {
    final state = null == widget.attributeId ? null : ref.watch(attributeStateNotifierProvider);

    return EditView(
      state,
      controller: ref.read(attributesControllerProvider),
      children: [
        const InvisibleField(name: "id"),
        NameField(
          label: AppLocalizations.of(context)!.attributeName,
          isLoading: state?.isLoading ?? false,
          initialValue: state?.valueOrNull?.name,
          readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
          icon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconPickerField(initialValue: state?.valueOrNull?.iconData),
          ),
        ),
        // BoolField(
        //   name: "isPassive",
        //   label: AppLocalizations.of(context)!.abilityIsPasive,
        //   isLoading: state?.isLoading ?? false,
        //   initialValue: state?.value?.isPassive ?? false,
        //   readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
        // ),
        DescriptionField(
          label: AppLocalizations.of(context)!.attributeDescription,
          isLoading: state?.isLoading ?? false,
          initialValue: state?.valueOrNull?.description,
          readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
        ),
      ],
    );
  }
}
