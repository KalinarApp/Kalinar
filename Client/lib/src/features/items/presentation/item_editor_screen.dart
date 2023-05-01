import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/default_scroll_view.dart';
import '../../../common_widgets/form_fields/description_field.dart';
import '../../../common_widgets/form_fields/image_picker_field.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/form_fields/name_field.dart';
import '../../../common_widgets/loading_indicator.dart';
import '../../../utilities/async_value_extension.dart';
import '../../group_management/application/group_notifier.dart';
import '../../traits/domain/attribute.dart';
import '../application/items_controller.dart';
import '../domain/item.dart';
import '../domain/item_type.dart';

class ItemEditorScreen extends ConsumerStatefulWidget {
  static const name = "ItemEditor";
  static const route = "editor";

  final String? id;
  final ItemType? type;

  const ItemEditorScreen(this.id, {this.type, super.key}) : assert(null != id || null != type);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemEditorScreenState();
}

class _ItemEditorScreenState extends ConsumerState<ItemEditorScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  late final ItemsController controller;

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.id ? await controller.create(data) : await controller.update(widget.id, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (!value.hasError) {
          GoRouter.of(context).pop();
        }
      }
    }
  }

  bool _isCreatorOrAdminOrNew(Item? item) {
    return widget.id == null || _isAdmin() || (null != item && item.creator.id == FirebaseAuth.instance.currentUser?.uid);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  Widget _buildImagePicker(Image? image, bool isLoading, BuildContext context) {
    Image? fittedImage = image;
    if (null != image) {
      fittedImage = Image(image: image.image, fit: BoxFit.fitHeight);
    }

    Widget placeholder = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Center(child: FaIcon(FontAwesomeIcons.camera)),
        const SizedBox(height: 5),
        Text(AppLocalizations.of(context)!.pickAnImage, textAlign: TextAlign.center),
      ],
    );

    Widget loadingWidget = SizedBox(
      width: double.infinity,
      child: Center(child: LoadingIndicator(AppLocalizations.of(context)!.uploadImage)),
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height * .36,
      // width: fittedImage == null ? double.infinity : null,
      child: Card(
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.hardEdge,
        child: isLoading ? loadingWidget : fittedImage ?? placeholder,
      ),
    );
  }

  @override
  void initState() {
    controller = ref.read(itemsNotifierProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FormBuilder(
        key: _formKey,
        child: DefaultScrollView(
          children: [
            InvisibleField(name: "type", initialValue: widget.type),
            ImagePickerField(name: "imageUrl", builder: (image, isLoading) => _buildImagePicker(image, isLoading, context)),
            const SizedBox(height: 8.0),
            NameField(name: "title", label: AppLocalizations.of(context)!.name),
            DescriptionField(label: AppLocalizations.of(context)!.description),
            const SizedBox(height: 8.0),
            // FormBuilderDropdown<ItemType>(
            //   name: "type",
            //   isExpanded: true,
            //   enabled: widget.id == null,
            //   valueTransformer: (value) => jsonEncode(value),
            //   initialValue: selectedType,
            //   onChanged: (value) => setState(() => selectedType = value ?? ItemType.item),
            //   decoration: InputDecoration(label: Text("${AppLocalizations.of(context)!.itemTypeSelection}:")),
            //   items: ItemType.values.map((e) => DropdownMenuItem<ItemType>(value: e, child: Text(e.getTitle(context)))).toList(),
            // ),

            if (widget.type == ItemType.Weapon)
              Column(children: [
                FormBuilderDropdown<Attribute>(
                  name: "attributeId",
                  isExpanded: true,
                  valueTransformer: (value) => value?.id,
                  items: [],
                  decoration: const InputDecoration(labelText: "Würfelattribut"),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Text("Würfeln:", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 50,
                      child: FormBuilderTextField(
                        name: "diceCount",
                        initialValue: "1",
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                        textInputAction: TextInputAction.next,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Text("d")),
                    SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: FormBuilderTextField(
                          name: "dice",
                          initialValue: "100",
                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 6), child: Text("+")),
                    SizedBox(
                      width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: FormBuilderTextField(
                          name: "bonus",
                          initialValue: "0",
                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: false),
                          textInputAction: TextInputAction.next,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _save,
              child: SizedBox(
                width: double.infinity,
                child: Center(child: Text(AppLocalizations.of(context)!.save, style: Theme.of(context).textTheme.titleLarge)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
