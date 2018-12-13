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

  String raw() {
    if (street == null && city == null && state == null && zip == null) {
      return "";
    }
    return "$street $apartment $city $state $zip".toString();
  }

  @override
  String toString() {
    if (raw().trim().isEmpty) {
      return "";
    }
    var _address = "";
    _address += "$street $apartment".trim();

    bool _city = city != null && city.isNotEmpty;
    bool _state = state != null && state.isNotEmpty;
    bool _zip = zip != null && zip.isNotEmpty;

    String _cityStateZip = "";
    if (_city && _state && _zip) {
      return "$city, $state $zip".trim();
    } else {
      if (_city || _state || _zip) {
        if (!_city) _cityStateZip = "$state $zip".trim();
        if (_city && !_state && !_zip) return "$city".trim();
        _cityStateZip = "$city, $state $zip".trim();
      }
    }

    if (_cityStateZip.isNotEmpty) {
      _address += "\n";
      _address += _cityStateZip;
    }

    return _address.trim().toString();
  }
}
