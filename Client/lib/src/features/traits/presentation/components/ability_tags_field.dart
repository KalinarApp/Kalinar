import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_tagging_plus/flutter_tagging_plus.dart';

class Tag extends Taggable {
  final String tag;

  const Tag(this.tag);

  @override
  List<Object> get props => [tag];

  String toJson() => tag;

  static Tag fromJson(dynamic data) => Tag(data.toString());
}

class AbilityTagsField extends StatefulWidget {
  final List<String>? initialValue;
  final Future<List<String>> Function(String query)? findSuggestion;
  final Function(List<String>? tags)? onChanged;

  const AbilityTagsField({this.initialValue, this.findSuggestion, this.onChanged, super.key});

  @override
  State<AbilityTagsField> createState() => _AbilityTagsFieldState();
}

class _AbilityTagsFieldState extends State<AbilityTagsField> {
  List<Tag> tags = [];

  List<Tag> _buildList(List<String>? value) {
    if (tags.length != value?.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            tags = [...value?.map((e) => Tag(e)) ?? []];
          }));
    }

    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<List<String>>(
      name: "tags",
      initialValue: widget.initialValue,
      onChanged: (value) => widget.onChanged?.call(value),
      builder: (field) => FlutterTagging<Tag>(
        initialItems: _buildList(field.value),
        findSuggestions: (query) async => (await widget.findSuggestion?.call(query))?.map((e) => Tag(e)).toList() ?? [],
        additionCallback: (tag) => Tag(tag),
        errorBuilder: (ctx, error) => SizedBox(
          height: 50,
          child:
              Center(child: Text(AppLocalizations.of(context)!.abilityFetchTagsFailed, style: TextStyle(color: Theme.of(context).colorScheme.error))),
        ),
        configureSuggestion: (p0) => SuggestionConfiguration(
          title: Text(p0.tag),
          additionWidget: Chip(
            avatar: const Icon(Icons.add_circle),
            label: Text(AppLocalizations.of(context)!.abilityAddTag),
            labelStyle: const TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w300),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        textFieldConfiguration: TextFieldConfiguration(
            scrollPadding: const EdgeInsets.only(bottom: 200),
            decoration:
                InputDecoration(hintText: AppLocalizations.of(context)!.abilityTags, helperText: AppLocalizations.of(context)!.abilityTagsHelpText)),
        onChanged: () => field.didChange(tags.map((e) => e.tag).toList()),
        configureChip: (p0) => ChipConfiguration(label: Text(p0.tag)),
      ),
    );
  }
}
