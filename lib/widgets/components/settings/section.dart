import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String name;
  final List<Widget> items;
  final bool initiallyExpanded;
  SettingsSection({this.name, this.items, this.initiallyExpanded = true});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: initiallyExpanded,
      title: Text(
        name ?? "Info",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: items,
    );
  }
}
