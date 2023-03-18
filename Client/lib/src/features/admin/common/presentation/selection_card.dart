import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SelectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const SelectionCard({required this.icon, required this.title, required this.route, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => GoRouter.of(context).push(route),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 64,
            width: 64,
            child: Card(
              elevation: 4,
              color: Theme.of(context).colorScheme.primary,
              child: Icon(icon, size: 32),
            ),
          ),
          Text(title)
        ],
      ),
    );
  }
}
