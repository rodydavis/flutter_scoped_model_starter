import 'package:contacts_service/contacts_service.dart';
import 'package:json_annotation/json_annotation.dart';

import '../general/address.dart';
import '../general/phone.dart';

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
//    this.companyCategory,
//    this.LeadGroups,
//    this.faxPhone,
//    this.secondCellPhone,
  });

  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  @JsonKey(name: 'email')
  String email;
  @JsonKey(name: 'current_address')
  Address currentAddress;
  @JsonKey(name: 'property_address')
  Address propertyAddress;
  @JsonKey(name: 'cell_phone')
  Phone cellPhone;
  @JsonKey(name: 'office_phone')
  Phone officePhone;
  @JsonKey(name: 'home_phone')
  Phone homePhone;
//  @JsonKey(name: 'Fax_Phone')
//  Phone faxPhone;
//  @JsonKey(name: 'Secondary_Cell_Phone')
//  Phone secondCellPhone;
//  @JsonKey(name: 'Company_Category')
//  CompanyCategory companyCategory;
//  @JsonKey(name: 'Lead_Groups')
//  List<LeadGroup> LeadGroups;

  factory LeadDetails.fromJson(Map<String, dynamic> json) =>
      _$LeadDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LeadDetailsToJson(this);

  /// Parse Phone Lead
  LeadDetails.fromPhoneContact(Contact contact) {
    firstName = contact?.givenName ?? "";
    // middleName = Lead?.middleName ?? "";
    lastName = contact?.familyName ?? "";

    // // -- Phones --
    // var _phones = Lead?.phones ?? [];
    // var _items = <Phone>[];
    // for (var _phone in _phones) {
    //   if (!_phone.label.contains("fax")) {
    //     if (_phone.label.contains("home")) {
    //       _items.add(Phone.fromString(
    //         _phone?.value ?? "",
    //         name: "home",
    //       ));
    //     }
    //     if (_phone.label.contains("office")) {
    //       _items.add(Phone.fromString(
    //         _phone?.value ?? "",
    //         name: "office",
    //       ));
    //     }
    //     if (_phone.label.contains("cell") || _phone.label.contains("mobile")) {
    //       _items.add(Phone.fromString(
    //         _phone?.value ?? "",
    //         name: "cell",
    //       ));
    //     }
    //   }
    // }
    // if (_items != null) phones = _items;

    // -- Emails --
    var _emails = contact?.emails ?? [];
    for (var _item in _emails) {
      email = _item.value;
    }

    // // - Addresses --
    // var _addresses = Lead?.postalAddresses ?? [];
    // for (var _address in _addresses) {
    //   address = Address(
    //     street: _address?.street ?? "",
    //     city: _address?.city ?? "",
    //     state: _address?.region ?? "",
    //     zip: _address?.postcode ?? "",
    //   );
    // }
  }
}
