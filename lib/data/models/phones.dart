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
}
