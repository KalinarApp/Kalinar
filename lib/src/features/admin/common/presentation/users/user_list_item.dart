import 'package:flutter/material.dart';

import 'package:flutter_gravatar/flutter_gravatar.dart';

import '../../../../authentication/domain/user_info.dart';

class UserListItem extends StatelessWidget {
  final UserInfo user;

  const UserListItem(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final gravatar = Gravatar(user.email);

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(gravatar.imageUrl())),
          title: Text("${user.firstname} ${user.lastname}"),
          subtitle: Text(user.username),
          // trailing: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     InkWell(borderRadius: BorderRadius.circular(12), onTap: () {}, child: const Icon(Icons.close, size: 20)),
          //   ],
          // ),
        ),
        const Divider()
      ],
    );
  }
}
