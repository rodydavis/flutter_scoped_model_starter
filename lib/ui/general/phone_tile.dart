import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/null_or_empty.dart';
import '../../utils/phoneCall.dart';
import '../../utils/sendSMS.dart';

class PhoneTile extends StatelessWidget {
  final String label, number;
  final IconData icon;
  
  PhoneTile({this.label, this.number, this.icon});

  @override
  Widget build(BuildContext context) {
    var _raw = (number ?? "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("-", "")
        .replaceAll(" ", "")
        .trim();
    if (isNullOrEmpty(_raw)) {
      return ListTile(
        leading: Icon(icon ?? Icons.phone),
        title: Text(
          isNullOrEmpty(label) ? 'Phone Number' : label,
          textScaleFactor: textScaleFactor,
        ),
        subtitle: const Text(
          "No Number Found",
          textScaleFactor: textScaleFactor,
        ),
      );
    }

    return ListTile(
      leading: Icon(icon ?? Icons.phone),
      title: Text(
        label ?? 'Phone Number',
        textScaleFactor: textScaleFactor,
      ),
      subtitle: Text(
        number,
        textScaleFactor: textScaleFactor,
      ),
      trailing: IconButton(
        icon: Icon(Icons.message),
        onPressed: () => sendSMS("", [_raw]),
      ),
      onTap: () => makePhoneCall(context, _raw),
    );
  }
}
