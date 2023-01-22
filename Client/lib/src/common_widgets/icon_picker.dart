import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class IconPicker extends StatefulWidget {
  final Color? iconColor;
  final IconData? initialValue;
  final Function(IconData? icon)? onChange;

  const IconPicker({this.onChange, this.iconColor, this.initialValue, super.key});

  @override
  State<IconPicker> createState() => _IconPickerState();
}

class _IconPickerState extends State<IconPicker> {
  IconData? selectedIcon;

  Future<void> _pickIcon(BuildContext context) async {
    final data = await FlutterIconPicker.showIconPicker(
      context,
      showTooltips: true,
      showSearchBar: true,
      barrierDismissible: true,
      title: Text(AppLocalizations.of(context)!.pickAnIcon),
      searchHintText: AppLocalizations.of(context)!.searchIcon,
      iconPackModes: IconPack.values,
      noResultsText: AppLocalizations.of(context)!.noIconSearchResults,
      closeChild: Text(AppLocalizations.of(context)!.cancel, textScaleFactor: 1.25),
    );

    if (null != data) {
      setState(() => selectedIcon = data);
      if (null != widget.onChange) widget.onChange!(data);
    }
  }

  @override
  void initState() {
    selectedIcon = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () => _pickIcon(context),
      onDoubleTap: () => setState(() => selectedIcon = null),
      child: Icon(
        selectedIcon ?? Icons.add_reaction,
        size: 32,
        color: widget.iconColor,
      ),
    );
  }
}
