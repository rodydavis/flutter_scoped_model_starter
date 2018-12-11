import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/null_or_empty.dart';
import '../../utils/sendEmail.dart';

ListTile buildEmailTile(BuildContext context,
    {String label, @required String email, IconData icon}) {
  if (isNullOrEmpty(email)) {
    return ListTile(
      leading: Icon(icon ?? Icons.email),
      title: Text(
        label ?? 'Email',
        textScaleFactor: textScaleFactor,
      ),
      subtitle: const Text(
        "No Email Found",
        textScaleFactor: textScaleFactor,
      ),
    );
  }
  return ListTile(
    leading: Icon(icon ?? Icons.email),
    title: Text(
      label ?? 'Email',
      textScaleFactor: textScaleFactor,
    ),
    subtitle: Text(
      email,
      textScaleFactor: textScaleFactor,
    ),
    onTap: () => sendEmail(context, recipients: [email]),
  );
}
