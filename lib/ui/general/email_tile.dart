import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/null_or_empty.dart';
import '../../utils/sendEmail.dart';

class EmailTile extends StatelessWidget {
  final String email, label;
  final IconData icon;

  EmailTile({
    this.label,
    @required this.email,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
}
