import 'package:json_annotation/json_annotation.dart';

import '../general/address.dart';
import '../general/phone.dart';
import '../unify/company_category.dart';
import '../unify/contact_group.dart';
import 'package:contacts_service/contacts_service.dart';

part 'contact_details.g.dart';

@JsonSerializable()
class ContactDetails {
  ContactDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.address,
    this.homePhone,
    this.cellPhone,
    this.officePhone,
    this.companyCategory,
    this.contactGroups,
    this.faxPhone,
    this.secondCellPhone,
  });

  @JsonKey(name: 'First_Name')
  String firstName;
  @JsonKey(name: 'Last_Name')
  String lastName;
  @JsonKey(name: 'Email_Address')
  String email;
  @JsonKey(name: 'Address')
  Address address;
  @JsonKey(name: 'Cell_Phone')
  Phone cellPhone;
  @JsonKey(name: 'Office_Phone')
  Phone officePhone;
  @JsonKey(name: 'Home_Phone')
  Phone homePhone;
  @JsonKey(name: 'Fax_Phone')
  Phone faxPhone;
  @JsonKey(name: 'Secondary_Cell_Phone')
  Phone secondCellPhone;
  @JsonKey(name: 'Company_Category')
  CompanyCategory companyCategory;
  @JsonKey(name: 'Contact_Groups')
  List<ContactGroup> contactGroups;

  factory ContactDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailsToJson(this);

  /// Parse Phone Contact
  ContactDetails.fromPhoneContact(Contact contact) {
    firstName = contact?.givenName ?? "";
    // middleName = contact?.middleName ?? "";
    lastName = contact?.familyName ?? "";

    // // -- Phones --
    // var _phones = contact?.phones ?? [];
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
    // var _addresses = contact?.postalAddresses ?? [];
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
