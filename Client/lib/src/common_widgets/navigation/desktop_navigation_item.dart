import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DesktopNavigationItem extends HookWidget {
  final Widget? icon;
  final ImageProvider? image;
  final bool isSelected;
  final Function()? onTap;

  const DesktopNavigationItem({this.icon, this.isSelected = false, this.image, this.onTap, super.key}) : assert(icon == null || image == null);

  @override
  Widget build(BuildContext context) {
    final isMouseOver = useState(false);

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        onEnter: (event) => isMouseOver.value = true,
        onExit: (event) => isMouseOver.value = false,
        child: AspectRatio(
          aspectRatio: 1,
          child: Row(
            children: [
              Container(
                width: 4,
                height: isSelected
                    ? 48
                    : isMouseOver.value
                        ? 12
                        : 0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isSelected || isMouseOver.value ? 12 : 100),
                  child: Container(
                    width: 48,
                    height: 48,
                    color: Theme.of(context).colorScheme.background,
                    child: image == null ? icon : Image(image: image!, fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
