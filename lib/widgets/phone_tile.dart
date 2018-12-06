// import 'package:flutter/material.dart';
// import '../utils/null_or_empty.dart';
// import '../utils/text_format.dart';
// import '../utils/sendSMS.dart';
// import '../utils/phoneCall.dart';

// ListTile buildPhoneTile(
//   BuildContext context, {
//   String label,
//   IconData icon,
//   @required String number,
// }) {
//   if (isNullOrEmpty(number)) {
//     return ListTile(
//       leading: Icon(icon ?? Icons.phone),
//       title: Text(
//         label ?? 'Phone Number',
//         textScaleFactor: textScaleFactor,
//       ),
//       subtitle: const Text(
//         "No Number Found",
//         textScaleFactor: textScaleFactor,
//       ),
//     );
//   }
//   return ListTile(
//     leading: Icon(icon ?? Icons.phone),
//     title: Text(
//       label ?? 'Phone Number',
//       textScaleFactor: textScaleFactor,
//     ),
//     subtitle: Text(
//       number,
//       textScaleFactor: textScaleFactor,
//     ),
//     trailing: IconButton(
//       icon: Icon(Icons.message),
//       onPressed: () => sendSMS("", [number]),
//     ),
//     onTap: () => makePhoneCall(context, number),
//   );
// }
