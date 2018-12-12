import '../general/address.dart';
import '../general/company_category.dart';
import '../general/contact_groups.dart';
import '../general/phones.dart';
import 'package:contacts_service/contacts_service.dart';

class ContactDetailsResult {
  String status;
  String message;
  ContactDetails result;

  ContactDetailsResult({this.status, this.message, this.result});

  ContactDetailsResult.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    result = json['Result'] != null
        ? new ContactDetails.fromJson(json['Result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result.toJson();
    }
    return data;
  }
}

class ContactDetails {
  String firstName;
  String middleName;
  String lastName;
  String email;
  Address address;
  List<Phones> phones;
  String birthdate;
  String integrationId;
  CompanyCategory companyCategory;
  List<ContactGroups> contactGroups;

  ContactDetails(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.address,
      this.phones,
      this.birthdate,
      this.integrationId,
      this.companyCategory,
      this.contactGroups});

  ContactDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['phones'] != null) {
      phones = new List<Phones>();
      json['phones'].forEach((v) {
        phones.add(new Phones.fromJson(v));
      });
    }
    birthdate = json['birthdate'];
    integrationId = json['integration_id'];
    companyCategory = json['company_category'] != null
        ? new CompanyCategory.fromJson(json['company_category'])
        : null;
    if (json['contact_groups'] != null) {
      contactGroups = new List<ContactGroups>();
      json['contact_groups'].forEach((v) {
        contactGroups.add(new ContactGroups.fromJson(v));
      });
    }
  }

  ContactDetails.fromPhoneContact(Contact contact) {
    firstName = contact?.givenName ?? "";
    middleName = contact?.middleName ?? "";
    lastName = contact?.familyName ?? "";

    // -- Phones --
    var _phones = contact?.phones ?? [];
    var _items = <Phones>[];
    for (var _phone in _phones) {
      if (!_phone.label.contains("fax")) {
        if (_phone.label.contains("home")) {
          _items.add(Phones.fromString(
            _phone?.value ?? "",
            name: "home",
          ));
        }
        if (_phone.label.contains("office")) {
          _items.add(Phones.fromString(
            _phone?.value ?? "",
            name: "office",
          ));
        }
        if (_phone.label.contains("cell") || _phone.label.contains("mobile")) {
          _items.add(Phones.fromString(
            _phone?.value ?? "",
            name: "cell",
          ));
        }
      }
    }
    if (_items != null) phones = _items;

    // -- Emails --
    var _emails = contact?.emails ?? [];
    for (var _item in _emails) {
      email = _item.value;
    }

    // - Addresses --
    var _addresses = contact?.postalAddresses ?? [];
    for (var _address in _addresses) {
      address = Address(
        street: _address?.street ?? "",
        city: _address?.city ?? "",
        state: _address?.region ?? "",
        zip: _address?.postcode ?? "",
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.phones != null) {
      data['phones'] = this.phones.map((v) => v.toJson()).toList();
    }
    data['birthdate'] = this.birthdate;
    data['integration_id'] = this.integrationId;
    if (this.companyCategory != null) {
      data['company_category'] = this.companyCategory.toJson();
    }
    if (this.contactGroups != null) {
      data['contact_groups'] =
          this.contactGroups.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
