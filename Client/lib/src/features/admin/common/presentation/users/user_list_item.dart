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
          title: Text(user.username.isNotEmpty ? user.username : user.email),
        ),
        const Divider()
      ],
    );
  }
}
