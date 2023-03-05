import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kalinar/src/common_widgets/custom_image_button.dart';

import '../../../../common_widgets/debounced_text_field.dart';
import '../../../../common_widgets/loading_indicator.dart';
import '../../../../utilities/async_value_extension.dart';
import '../../application/abilities_controller.dart';
import '../../application/abilities_state_notifier.dart';
import 'ability_list_item.dart';

class AbilitiesTab extends ConsumerStatefulWidget {
  const AbilitiesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AbilitiesTabState();
}

class _AbilitiesTabState extends ConsumerState<AbilitiesTab> {
  Future _onRefresh() async {
    final value = await ref.read(abilitiesControllerProvider).getAll();
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(abilityStateNotifierProvider);

    return null == state
        ? LoadingIndicator(AppLocalizations.of(context)!.listLoading)
        : state.isEmpty
            ? Center(child: Text(AppLocalizations.of(context)!.listEmpty))
            : RefreshIndicator(
                onRefresh: _onRefresh,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.only(bottom: 5, left: 4, right: 4),
                      sliver: SliverToBoxAdapter(
                          child: Row(
                        children: [
                          Flexible(
                            child: DebouncedTextField(
                              title: AppLocalizations.of(context)!.search,
                              onChanged: (currentText) {},
                            ),
                          ),
                          CustomImageButton(icon: const FaIcon(FontAwesomeIcons.filter), onPressed: () {})
                        ],
                      )),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) => AbilityListItem(state[index]), childCount: state.length),
                    )
                  ],
                ),
              );
  }
}
