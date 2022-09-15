import 'package:flutter/material.dart';

class HeroSelector extends StatefulWidget {
  const HeroSelector({super.key});

  @override
  State<HeroSelector> createState() => _HeroSelectorState();
}

class _HeroSelectorState extends State<HeroSelector> {
  String? value = "Gwynbleidd";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      style: const TextStyle(color: Colors.black),
      value: value,
      items: const [
        DropdownMenuItem(
          value: "Gwynbleidd",
          child: Text("Gwynbleidd"),
        ),
        DropdownMenuItem(
          value: "Vind",
          child: Text("Vind"),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() => value = newValue);
      },
    );
  }
}
