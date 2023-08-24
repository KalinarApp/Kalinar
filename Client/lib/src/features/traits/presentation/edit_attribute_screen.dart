import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/icon_picker_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../../../common_widgets/form_fields/typeahead_text_field.dart';
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
  static final _formKey = GlobalKey<FormBuilderState>();
  final categoriesController = TextEditingController();

  bool _isCreatorOrAdminOrNew(Attribute? item) {
    return widget.attributeId == null ||
        _isAdmin() ||
        (null != item?.creator && item!.creator!.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    // return FirebaseAuth.instance.currentUser?.uid == ref.read(userNotifierProvider).user?.ownedGroup?.ownerId;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(attributeStateNotifierProvider, (previous, next) {
      if (null == previous || previous.isLoading) {
        categoriesController.text = next.valueOrNull?.category ?? "";
        _formKey.currentState?.fields["category"]?.didChange(categoriesController.text);
      }
    });

    final state = null == widget.attributeId ? null : ref.watch(attributeStateNotifierProvider);

    return EditView(
      state,
      formKey: _formKey,
      controller: ref.read(attributesControllerProvider),
      errorWidget: Center(child: Text(AppLocalizations.of(context)!.loadAttributeFailed)),
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
        DescriptionField(
          label: AppLocalizations.of(context)!.attributeDescription,
          isLoading: state?.isLoading ?? false,
          initialValue: state?.valueOrNull?.description,
          readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
        ),
        TypeAheadTextField(
          name: "category",
          controller: categoriesController,
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeCategory, prefixIcon: const Icon(Icons.category)),
          itemBuilder: (context, itemData) => ListTile(title: Text(itemData)),
          suggestionsCallback: (pattern) async => await ref.read(attributesControllerProvider).getCategories(pattern),
          getImmediateSuggestions: false,
          hideOnEmpty: true,
          hideOnError: true,
          hideOnLoading: true,
          hideSuggestionsOnKeyboardHide: true,
          enabled: _isCreatorOrAdminOrNew(state?.valueOrNull),
          keepSuggestionsOnLoading: true,
        ),
        FormBuilderTextField(
          name: "stepSize",
          initialValue: (state?.valueOrNull?.stepSize ?? 1).toString(),
          decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeStepSize, prefixIcon: const SizedBox(width: 24)),
          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          enabled: _isCreatorOrAdminOrNew(state?.valueOrNull),
        ),
        FormBuilderTextField(
            name: "minValue",
            initialValue: (state?.valueOrNull?.minValue ?? 0).toString(),
            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeMinValue, prefixIcon: const SizedBox(width: 24)),
            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            enabled: _isCreatorOrAdminOrNew(state?.valueOrNull)),
        FormBuilderTextField(
            name: "maxValue",
            initialValue: (state?.valueOrNull?.maxValue ?? 10).toString(),
            decoration: InputDecoration(labelText: AppLocalizations.of(context)!.attributeMaxValue, prefixIcon: const SizedBox(width: 24)),
            keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            enabled: _isCreatorOrAdminOrNew(state?.valueOrNull)),
      ],
    );
  }
}
