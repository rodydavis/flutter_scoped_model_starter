class Phones {
  String label;
  String areaCode;
  String prefix;
  String number;
  String ext;

  Phones({this.label, this.areaCode, this.prefix, this.number});

  Phones.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    areaCode = json['area_code'];
    prefix = json['prefix'];
    number = json['number'];
    if (json['extension'] != null) ext = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['area_code'] = this.areaCode;
    data['prefix'] = this.prefix;
    data['number'] = this.number;
    if (ext != null) data['extension'] = this.ext;
    return data;
  }

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

  Phones.fromString(String value, {String name}) {
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
