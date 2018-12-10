import 'package:flutter/material.dart';

import 'popUp.dart';
import 'url.dart';

makePhoneCall(BuildContext context, String phone) async {
  if (phone.length > 0) {
    String call = phone.replaceAll(RegExp(r'-'), '');
    String url = 'tel:+1$call';
    launchURL(url);
  } else {
    showAlertPopup(context, 'Info', 'Phone Number Not Found');
  }
}
