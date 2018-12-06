// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// import 'popUp.dart';
// import 'url.dart';

// openMaps(BuildContext context, String address, {bool googleMaps = true}) async {
//   print("Searching for: $address");
//   String googlePrefix =
//       Platform.isIOS ? "comgooglemaps://?q=" : "http://maps.google.com/?q=";
//   String applePrefix = "http://maps.apple.com/?q=";
//   String addressString = address;
//   addressString = addressString.replaceAll(RegExp(r' '), '+');
//   addressString = addressString.replaceAll(RegExp(r','), '%2C');
//   addressString = addressString.replaceAll(RegExp(r'\n'), '+');

//   String googleUrl = googlePrefix + addressString;
//   String appleUrl = applePrefix + addressString;
//   if (await checkGoogleMapsInstalled() && googleMaps || Platform.isAndroid) {
//     print('launching com googleUrl: $googleUrl');
//     await launchURL(googleUrl);
//   } else if (await canLaunch(appleUrl)) {
//     print('launching apple url $appleUrl');
//     await launchURL(appleUrl);
//   } else {
//     // // throw 'Could not launch url';
//     showAlertPopup(context, "Info", "Could Not Open Address");
//     print('***\n$googleUrl\n$appleUrl\n***');
//   }
// }

// Future<bool> checkGoogleMapsInstalled() async {
//   bool _isGoogleMapsInstalled = await canLaunch('comgooglemaps://');
//   return Platform.isAndroid ? true : _isGoogleMapsInstalled;
// }
