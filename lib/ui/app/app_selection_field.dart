import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants.dart';
import '../general/native_selection.dart';

class AppInputSelection extends StatelessWidget {
  final bool showMaterial;
  final String selection, label;
  final List<String> items;
  final ValueChanged<String> onSelected;

  AppInputSelection({
    this.showMaterial = false,
    @required this.selection,
    @required this.items,
    this.onSelected,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && !showMaterial) {
      return ListTile(
        leading: Icon(Icons.label),
        title: Text(
          label ?? 'Select an Item',
          textScaleFactor: textScaleFactor,
        ),
        subtitle: Text(
          selection,
          textScaleFactor: textScaleFactor,
        ),
        trailing: items != null && items.length == 1
            ? CircularProgressIndicator()
            : null,
        onTap: () async {
          await showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return NativeSelection(
                value: selection,
                items: items,
                onChanged: onSelected,
              );
            },
          );
        },
      );
    }
    return ListTile(
      leading: Icon(Icons.label),
      title: Text(
        'Select a Response',
        textScaleFactor: textScaleFactor,
      ),
      subtitle: NativeSelection(
        showMaterial: showMaterial,
        value: selection,
        items: items,
        onChanged: onSelected,
      ),
      trailing: items != null && items.length == 1
          ? CircularProgressIndicator()
          : null,
    );
  }
}
