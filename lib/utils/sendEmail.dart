import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'popUp.dart';
import 'url.dart';

sendEmail(BuildContext context,
    {List<String> recipients,
    String body,
    String subject,
    List<String> cc,
    List<String> bcc}) async {
  final Email _email = Email(
    body: body,
    subject: subject,
    recipients: recipients,
    cc: cc,
    bcc: bcc,
    // attachmentPath: '/path/to/attachment.zip',
  );
  try {
    await FlutterEmailSender.send(_email);
  } catch (e) {
    if (recipients.isNotEmpty) {
      String url = 'mailto:${recipients.first.toString()}';
      launchURL(url);
    } else {
      showAlertPopup(context, 'Info', 'Email Not Found');
    }
  }
}
