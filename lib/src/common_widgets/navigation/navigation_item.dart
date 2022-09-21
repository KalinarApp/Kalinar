import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;
  final bool isVisible;

  const NavigationItem({required this.title, required this.icon, required this.route, this.isVisible = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: () => Navigator.popAndPushNamed(context, route),
        child: ListTile(
          title: Text(title),
          leading: Icon(icon),
        ),
      ),
    );
  }
}
