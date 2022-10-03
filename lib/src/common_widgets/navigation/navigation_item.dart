import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final bool isVisible;

  const NavigationItem({required this.title, required this.icon, required this.route, this.isVisible = false, super.key});

  @override
  Widget build(BuildContext context) {
    final isCurrentRoute = ModalRoute.of(context)!.settings.name == route;
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: isCurrentRoute ? null : () => Navigator.popAndPushNamed(context, route),
        child: ListTile(
          tileColor: isCurrentRoute ? Theme.of(context).primaryColorLight.withOpacity(.7) : Colors.transparent,
          title: Text(title),
          leading: Icon(icon),
        ),
      ),
    );
  }
}
