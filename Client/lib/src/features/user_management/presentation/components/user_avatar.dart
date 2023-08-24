import 'package:flutter/material.dart';
import 'package:kalinar/src/features/user_management/presentation/components/custom_user_avatar.dart';

import 'default_user_avatar.dart';

class UserAvatar extends StatelessWidget {
  final double? radius;
  final String? imageUrl;

  const UserAvatar({super.key, this.radius, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl != null ? CustomUserAvatar(imageUrl: imageUrl!, radius: radius) : DefaultUserAvatar(radius: radius);
  }
}
