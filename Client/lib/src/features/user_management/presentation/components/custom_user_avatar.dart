import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/build_context_extensions.dart';

class CustomUserAvatar extends StatelessWidget {
  final double? radius;
  final String imageUrl;

  const CustomUserAvatar({super.key, this.radius, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.colorScheme.onSurfaceVariant,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
    );
  }
}
