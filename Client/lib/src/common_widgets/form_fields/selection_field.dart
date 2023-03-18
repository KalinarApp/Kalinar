import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class SelectionField<T> extends ConsumerWidget {
  final String name;
  final T? initialValue;
  final String? label;
  final Widget? icon;

  final Future<List<T>> Function(String? query) items;
  final dynamic Function(T? value)? transformer;
  final bool Function(T item1, T item2)? compareFn;
  final String Function(T item)? asString;
  final String? searchLabel;
  final String? searchHint;
  final Function()? onAddPressed;
  final String? Function(T? value)? validator;
  final Future<bool?> Function(T? previous, T? next)? onChanged;

  const SelectionField(
      {required this.name,
      this.label,
      this.searchLabel,
      this.searchHint,
      required this.items,
      this.compareFn,
      this.asString,
      this.initialValue,
      this.icon,
      this.transformer,
      this.onAddPressed,
      this.onChanged,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Flexible(
          child: FormBuilderSearchableDropdown<T>(
            name: name,
            onBeforeChange: onChanged,
            valueTransformer: transformer,
            initialValue: initialValue,
            validator: validator,
            decoration: InputDecoration(labelText: label, prefixIcon: icon),
            asyncItems: items,
            compareFn: compareFn,
            itemAsString: asString,
            clearButtonProps: const ClearButtonProps(isVisible: true),
            dropdownSearchDecoration: InputDecoration(hintText: searchHint),
            popupProps: PopupProps.modalBottomSheet(
              modalBottomSheetProps: ModalBottomSheetProps(elevation: 16, backgroundColor: Theme.of(context).dialogBackgroundColor),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(border: const UnderlineInputBorder(), labelText: searchLabel),
              ),
            ),
          ),
        ),
        if (null != onAddPressed)
          IconButton(
            onPressed: onAddPressed,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: const Icon(Icons.add, size: 32),
          )
      ],
    );
  }
}
