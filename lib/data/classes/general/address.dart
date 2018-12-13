import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  Address({this.street, this.apartment, this.state, this.city, this.zip});

  String street;
  String apartment;
  String state;
  String city;
  String zip;
  String county;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
