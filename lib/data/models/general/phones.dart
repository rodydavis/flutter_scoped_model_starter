class Phones {
  String label;
  String areaCode;
  String prefix;
  String number;

  Phones({this.label, this.areaCode, this.prefix, this.number});

  Phones.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    areaCode = json['area_code'];
    prefix = json['prefix'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['area_code'] = this.areaCode;
    data['prefix'] = this.prefix;
    data['number'] = this.number;
    return data;
  }

  String raw() {
    if (areaCode == null || prefix == null || number == null) {
      return "";
    }
    try {
      return "$areaCode$prefix$number".toString();
    } catch (e) {
      print(e);
      return "";
    }
  }

  Phones.fromString(String value, {String name}) {
    label = name ?? "phone";
    var _number = value
        .replaceAll("+", "")
        .replaceAll("-", "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(" ", "")
        .trim();
    if (_number.length >= 10) {
      if (_number.length == 10) {
        areaCode = value.substring(0, 3);
        prefix = value.substring(3, 6);
        number = value.substring(6, 10);
      }
    }
  }

  @override
  String toString() {
    return "($areaCode) $prefix-$number".toString();
  }
}
