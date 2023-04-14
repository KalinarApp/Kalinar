import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common_widgets/loading_indicator.dart';
import '../../application/user_list_controller.dart';
import 'user_list_item.dart';

class UserList extends ConsumerStatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListState();
}

class _UserListState extends ConsumerState<UserList> {
  late UserListController controller;

  Future<void> _refresh() async {
    await controller.getMembers();
  }

  @override
  void initState() {
    controller = ref.read(userListControllerProvider.notifier);
    Future.delayed(Duration.zero, _refresh);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userListControllerProvider);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${AppLocalizations.of(context)!.members}:", style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                onPressed: _refresh,
                icon: const Icon(Icons.refresh),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (value) {
                value.disallowIndicator();
                return true;
              },
              child: state.when(
                data: (data) => ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, index) => data[index].email.isEmpty ? Container() : UserListItem(data[index]),
                ),
                error: (error, _) => Center(child: Text(AppLocalizations.of(context)!.fetchMembersFailed)),
                loading: () => LoadingIndicator(AppLocalizations.of(context)!.fetchMembers),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
