import 'package:json_annotation/json_annotation.dart';
import '../../../utils/null_or_empty.dart';
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

  String raw() {
    if (street == null && city == null && state == null && zip == null) {
      return "";
    }
    return "$street $apartment $city $state $zip".trim().toString();
  }

  @override
  String toString() {
    if (raw().isEmpty) {
      return "";
    }
    var _address = "";
    _address += "$street $apartment".trim();

    bool _city = !isNullOrEmpty(city);
    bool _state = !isNullOrEmpty(state);
    bool _zip = !isNullOrEmpty(zip);

    String _cityStateZip = "";
    if (_city || _state || _zip) {
      if (_city) {
        _cityStateZip = "$city, $state $zip".trim();
      } else {
        _cityStateZip = "$state $zip".trim();
      }
    }

    if (_cityStateZip.isNotEmpty) {
      _address += "\n";
      _address += _cityStateZip;
    }
    return _address.trim().toString();
  }
}
