// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../../../features/traits/domain/attribute.dart';
// import '../selection_field.dart';

// class AttributeSearch extends ConsumerWidget {
//   final List<Attribute> selectedAttributes;
//   final Function(Attribute selected)? onSelect;

//   const AttributeSearch({this.onSelect, this.selectedAttributes = const [], super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return SelectionField<Attribute>(
//       name: "attributeId",
//       asString: (item) => item.translate(context).name,
//       compareFn: (item1, item2) => item1.name == item2.name,
//       label: AppLocalizations.of(context)!.selectAnAttribute,
//       searchHint: AppLocalizations.of(context)!.attributeSearch,
//       searchLabel: AppLocalizations.of(context)!.attributeSearch,
//       transformer: (value) => value?.id,
//       icon: const Icon(FontAwesomeIcons.tags),
//       items: (_) async {
//         final all = await ref.read(attributeControllerProvider).getAll();
//         return all.where((x) => !selectedAttributes.any((y) => x.id == y.id)).toList();
//       },
//       onChanged: (previous, next) async {
//         if (null != onSelect && null != next) {
//           onSelect!(next);
//         }
//         return false;
//       },
//     );
//   }
// }
