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
}
