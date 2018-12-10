class Address {
  String street;
  String apartment;
  String state;
  String city;
  String zip;

  Address({this.street, this.apartment, this.state, this.city, this.zip});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    apartment = json['apartment'];
    state = json['state'];
    city = json['city'];
    zip = json['zip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['apartment'] = this.apartment;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip'] = this.zip;
    return data;
  }
}
