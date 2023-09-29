import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:kalinar/src/features/user_management/presentation/components/user_avatar.dart';

import '../../../../constants/app_sizes.dart';
import '../../../user_management/domain/user.dart';

class UserToken extends StatelessWidget {
  final User? creator;

  const UserToken({super.key, required this.creator});

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      content: Padding(padding: const EdgeInsets.all(Sizes.p8), child: Text(creator?.username ?? "")),
      child: UserAvatar(radius: 10, imageUrl: creator?.imageUrl),
    );
  }
}
