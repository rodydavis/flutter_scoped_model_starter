import 'package:contacts_service/contacts_service.dart';
import 'package:json_annotation/json_annotation.dart';

import '../general/address.dart';
import '../general/phone.dart';
import '../unify/contact_group.dart';

part 'lead_details.g.dart';

@JsonSerializable()
class LeadDetails {
  LeadDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.currentAddress,
    this.propertyAddress,
    this.homePhone,
    this.cellPhone,
    this.officePhone,
    this.leadGroups,
    this.dateModified,
    this.dateCreated,
  });

  @JsonKey(name: 'First_Name')
  String firstName;

  @JsonKey(name: 'Last_Name')
  String lastName;

  @JsonKey(name: 'Email_Address')
  String email;

  @JsonKey(name: 'Current_Address')
  Address currentAddress;

  @JsonKey(name: 'Property_Address')
  Address propertyAddress;

  @JsonKey(name: 'Cell_Phone')
  Phone cellPhone;

  @JsonKey(name: 'Office_Phone')
  Phone officePhone;

  @JsonKey(name: 'Home_Phone')
  Phone homePhone;

  @JsonKey(name: 'Date_Created')
  String dateCreated;

  @JsonKey(name: 'Date_Modified')
  String dateModified;

  @JsonKey(name: 'Lead_Groups')
  List<ContactGroup> leadGroups;

  factory LeadDetails.fromJson(Map<String, dynamic> json) =>
      _$LeadDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LeadDetailsToJson(this);

  /// Parse Lead from Phone Contact
  LeadDetails.fromPhoneContact(Contact contact) {
    print("Importing => " + contact?.displayName);

    firstName = contact?.givenName ?? "";
    print("First Name: $firstName");

    // middleName = contact?.middleName ?? "";

    lastName = contact?.familyName ?? "";
    print("Last Name: $lastName");

    // -- Phones --
    var _phones = contact?.phones ?? [];
    for (var _phone in _phones) {
      if (!_phone.label.contains("fax")) {
        if (_phone.label.contains("home")) {
          homePhone = Phone.fromString(
            _phone?.value ?? "",
            name: "home",
          );
          print("Home Phone: ${homePhone.toString()}");
        }
        if (_phone.label.contains("office")) {
          officePhone = Phone.fromString(
            _phone?.value ?? "",
            name: "office",
          );
          print("Office Phone: ${officePhone.toString()}");
        }
        if (_phone.label.contains("cell") || _phone.label.contains("mobile")) {
          cellPhone = Phone.fromString(
            _phone?.value ?? "",
            name: "cell",
          );
          print("Cell Phone: ${cellPhone.toString()}");
        }
      }
    }

    // -- Emails --
    var _emails = contact?.emails ?? [];
    for (var _item in _emails) {
      email = _item.value;
      print("Email: $email");
    }

    // - Addresses --
    var _addresses = contact?.postalAddresses ?? [];
    for (var _address in _addresses) {
      if (_address.label.toLowerCase().trim().contains("home"))
        currentAddress = Address(
          street: _address?.street ?? "",
          city: _address?.city ?? "",
          state: _address?.region ?? "",
          zip: _address?.postcode ?? "",
        );

      if (_address.label.toLowerCase().trim().contains("work"))
        propertyAddress = Address(
          street: _address?.street ?? "",
          city: _address?.city ?? "",
          state: _address?.region ?? "",
          zip: _address?.postcode ?? "",
        );
    }
  }
}
