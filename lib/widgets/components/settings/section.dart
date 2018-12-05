import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final String name;
  final List<Widget> items;
  SettingsSection({this.items, this.name});
  @override
  Widget build(BuildContext context) {
    List<Widget> _items = [
      ListTile(
          title: Text(
        name ?? "Theme",
        style: TextStyle(fontWeight: FontWeight.bold),
      )),
    ];
    if (items != null) {
      for (var _widget in items) {
        _items.add(_widget);
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _items,
    );
  }
}
