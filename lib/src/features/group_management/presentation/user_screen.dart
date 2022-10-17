import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/user_menu.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: UserMenu(),
          )
        ],
      ),
      body: Container(
        child: Text("User"),
      ),
    );
  }
}
