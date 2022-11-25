import 'package:flutter/material.dart';

import 'package:flutter_gravatar/flutter_gravatar.dart';

import '../../../../authentication/domain/user_info.dart';

class UserListItem extends StatelessWidget {
  final UserInfo user;

  const UserListItem(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    final gravatar = Gravatar(user.email);

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(gravatar.imageUrl())),
      title: Text("${user.firstname} ${user.lastname}"),
      subtitle: Text(user.username),
      // trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
    );
  }
}
