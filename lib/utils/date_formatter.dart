// import 'package:intl/intl.dart';

// String formatDate(String value) {
//   if (value == null || value.isEmpty) return "";
//   DateTime date = parseDate(value);
//   if (date.year < 1900) return "";
//   return formatDateCustom(date, format: 'MM-dd-yy');
// }

// String formatDateCustom(DateTime value, {String format = "MM-dd-yyyy"}) {
//   return DateFormat(format).format(value);
// }

// DateTime parseDate(String value) {
//   DateTime date;
//   try {
//     date = DateTime.parse(value);
//   } catch (e) {
//     return null;
//   }
//   return date;
// }
