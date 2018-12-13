import 'package:json_annotation/json_annotation.dart';

part 'contact_module.g.dart';

@JsonSerializable()
class ContactModule {
  ContactModule({this.street, this.apartment, this.state, this.city, this.zip});

  String street;
  String apartment;
  String state;
  String city;
  String zip;
  String county;

  factory ContactModule.fromJson(Map<String, dynamic> json) =>
      _$ContactModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModuleToJson(this);
}
