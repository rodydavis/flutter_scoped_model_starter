import 'package:json_annotation/json_annotation.dart';

part 'phone.g.dart';

@JsonSerializable()
class Phone {
  Phone({this.label, this.areaCode, this.ext, this.number, this.prefix});

  String label;
  String areaCode;
  String prefix;
  String number;
  String ext;

  factory Phone.fromJson(Map<String, dynamic> json) => _$PhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneToJson(this);

  /// Get the raw Phone Number eg. 387338763
  String raw() {
    if (areaCode == null && prefix == null && number == null) {
      return "";
    }
    try {
      if (ext != null) {
        return "$areaCode$prefix$number,$ext".toString();
      }
      return "$areaCode$prefix$number".toString();
    } catch (e) {
      print(e);
      return "";
    }
  }

  /// Get a Phone Number from a 10 digit string (after symbols removed)
  Phone.fromString(String value, {String name}) {
    label = name ?? "phone";
    var _number = replaceCommon(value);
    if (_number.length >= 10) {
      areaCode = _number.substring(0, 3);
      prefix = _number.substring(3, 6);
      number = _number.substring(6, 10);
      // if (_number.length > 10) {
      //   ext = value.substring(10, _number.length);
      // }
    }
    // print("Convert Number => $value | $_number");
  }

  /// Remove Common Symbols in Phone Numbers
  String replaceCommon(String value) {
    var _number = value
        .replaceAll("+", "")
        .replaceAll("-", "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(" ", "")
        .replaceAll(",", "")
        .trim();
    return _number;
  }

  @override
  String toString() {
    if (raw().isEmpty) return "";
    // if (ext != null) {
    //   return "($areaCode) $prefix-$number ;$ext".toString();
    // }
    return "($areaCode) $prefix-$number".toString();
  }
}
