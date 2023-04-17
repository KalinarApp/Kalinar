import 'dart:math';

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../../group_management/application/group_notifier.dart';
import '../application/controller/attributes_controller.dart';
import '../application/controller/races_controller.dart';
import '../application/notifier/race_state_notifier.dart';
import '../domain/attribute_value.dart';
import '../domain/race.dart';
import '../domain/suggestion_state.dart';
import 'components/attributes_field.dart';
import 'components/edit_view.dart';

class EditRaceScreen extends ConsumerStatefulWidget {
  static const String name = "EditRace";
  static const route = "race";

  final String? raceId;

  const EditRaceScreen(this.raceId, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditRaceScreenState();
}

class _EditRaceScreenState extends ConsumerState<EditRaceScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  bool _isCreatorOrAdminOrNew(Race? item) {
    return widget.raceId == null ||
        _isAdmin() ||
        (null != item?.creator && item!.creator!.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  @override
  void didChangeDependencies() {
    if (null == widget.raceId) {
      Future.delayed(Duration.zero, () async {
        final globalAttributes = await ref.read(attributesControllerProvider).getAllGlobal()
          ..sortBy((element) => element.name);
        _formKey.currentState?.fields["attributes"]
            ?.didChange(globalAttributes.map((e) => AttributeValue(attributeId: e.id, attribute: e, value: max(e.minValue, 0))).toList());
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(raceStateNotifierProvider, (previous, next) {
      if (null == previous || previous.isLoading) {
        _formKey.currentState?.fields["attributes"]?.didChange(next.valueOrNull?.attributes);
      }
    });
    final state = null == widget.raceId ? null : ref.watch(raceStateNotifierProvider);

    return EditView(
      state,
      formKey: _formKey,
      controller: ref.read(racesControllerProvider),
      errorWidget: Center(child: Text(AppLocalizations.of(context)!.loadRaceFailed)),
      children: [
        const InvisibleField(name: "id"),
        NameField(
          label: AppLocalizations.of(context)!.raceName,
          isLoading: state?.isLoading ?? false,
          initialValue: state?.valueOrNull?.name,
          readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
        ),
        DescriptionField(
          label: AppLocalizations.of(context)!.raceDescription,
          isLoading: state?.isLoading ?? false,
          initialValue: state?.valueOrNull?.description,
          readOnly: !_isCreatorOrAdminOrNew(state?.valueOrNull),
        ),
        const SizedBox(height: 30),
        AttributesField(initialValue: state?.valueOrNull?.attributes, alwaysShowGlobal: true),
      ],
    );
  }
}
