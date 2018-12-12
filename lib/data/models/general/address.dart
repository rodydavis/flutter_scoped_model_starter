class Address {
  String street;
  String apartment;
  String state;
  String city;
  String zip;
  String county;

  Address({this.street, this.apartment, this.state, this.city, this.zip});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    apartment = json['apartment'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
    county = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['apartment'] = this.apartment;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['county'] = "";
    return data;
  }

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
    if (_cityStateZip().isNotEmpty) {
      _address += "\n";
      _address += _cityStateZip();
    }
    return _address.trim().toString();
  }

  String _cityStateZip() {
    bool _city = city != null && city.isNotEmpty;
    bool _state = state != null && state.isNotEmpty;
    bool _zip = zip != null && zip.isNotEmpty;
    if (_city && _state && _zip) {
      return "$city, $state $zip".trim();
    } else {
      if (_city || _state || _zip) {
        if (!_city) return "$state $zip".trim();
        if (_city && !_state && !_zip) return "$city".trim();
        return "$city, $state $zip".trim();
      }
    }
    return "";
  }
}
