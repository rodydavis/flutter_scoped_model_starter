import 'null_or_empty.dart';

String convertNamesToLetters(String value1, String value2) {
  String _f, _l;
  if (!isNullOrEmpty(value1)) {
    final String _value1 = value1.substring(0, 1);
    _f = _value1;
  } else {
    _f = "";
  }
  if (!isNullOrEmpty(value2)) {
    final String _value2 = value2.substring(0, 1);
    _l = _value2;
  } else {
    _l = "";
  }
  return "$_f $_l".trim();
}
