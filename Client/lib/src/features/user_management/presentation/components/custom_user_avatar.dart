import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomUserAvatar extends StatelessWidget {
  final double? radius;
  final String imageUrl;

  const CustomUserAvatar({super.key, this.radius, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      backgroundImage: CachedNetworkImageProvider(imageUrl),
      child: Icon(Icons.person_4, size: 80, color: Theme.of(context).dialogBackgroundColor),
    );
  }
}
