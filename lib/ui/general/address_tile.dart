import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/openMaps.dart';

class AddressTile extends StatelessWidget {
  final String label, address;
  final IconData icon;

  AddressTile({
    @required this.address,
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (address == null || address.isEmpty) {
      return ListTile(
          leading: Icon(icon ?? Icons.map),
          title: Text(
            label ?? 'Address',
            textScaleFactor: textScaleFactor,
          ),
          subtitle: Text(
            "No Address Found",
            textScaleFactor: textScaleFactor,
          ));
    }
    return ListTile(
      leading: Icon(icon ?? Icons.map),
      title: Text(
        label ?? 'Address',
        textScaleFactor: textScaleFactor,
      ),
      subtitle: Text(
        address,
        textScaleFactor: textScaleFactor,
      ),
      onTap: () => openMaps(context,
          address.toString().replaceAll('\n', ' ').replaceAll(',', '')),
    );
  }
}
