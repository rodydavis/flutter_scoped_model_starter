import 'package:json_annotation/json_annotation.dart';

import '../general/phone.dart';

part 'lead_row.g.dart';
// import '../../models/contact/fields.dart';

class LeadFields {
  static const String id = 'Lead ID';
  static const String objectType = "Lead";
  // STARTER: fields - do not remove comment
  static const String contact_id = 'Contact ID';
  static const String first_name = 'First Name';
  static const String last_name = 'Last Name';
  static const String cell_phone = 'Cell Phone';
  static const String office_phone = 'Office Phone';
  static const String home_phone = 'Home Phone';
  static const String date_created = 'Date Created';
  static const String date_modified = 'Date Modified';
  static const String email = 'Email Address';
//  static const String last_activity = 'Last Activity';
}

@JsonSerializable()
class LeadRow {
  LeadRow({
    this.id,
    this.firstName,
    this.lastName,
    this.cellPhone,
    this.officePhone,
    this.homePhone,
    this.dateCreated,
    this.dateModified,
    this.email,
//    this.lastActivity,
    this.contactId,
  });

  @JsonKey(name: 'Lead_ID')
  String id;

  @JsonKey(name: 'Contact_ID')
  String contactId;

  @JsonKey(name: 'First_Name')
  String firstName;

  @JsonKey(name: 'Last_Name')
  String lastName;

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

  @JsonKey(name: 'Email_Address')
  String email;

//  @JsonKey(name: 'last_activity')
//  String lastActivity;

  factory LeadRow.fromJson(Map<String, dynamic> json) =>
      _$LeadRowFromJson(json);

  Map<String, dynamic> toJson() => _$LeadRowToJson(this);

  int compareTo(LeadRow object, String sortField, bool sortAscending) {
    int response = 0;
    LeadRow objectA = sortAscending ? this : object;
    LeadRow objectB = sortAscending ? object : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case LeadFields.first_name:
        response = objectA.firstName.compareTo(objectB.firstName);
        break;
      case LeadFields.last_name:
        response = objectA.lastName.compareTo(objectB.lastName);
        break;
      case LeadFields.cell_phone:
        response = objectA.cellPhone.raw().compareTo(objectB.cellPhone.raw());
        break;
      case LeadFields.office_phone:
        response =
            objectA.officePhone.raw().compareTo(objectB.officePhone.raw());
        break;
      case LeadFields.home_phone:
        response = objectA.homePhone.raw().compareTo(objectB.homePhone.raw());
        break;
      case LeadFields.date_created:
        response = objectA.dateCreated.compareTo(objectB.dateCreated);
        break;
      case LeadFields.date_modified:
        response = objectA.dateModified.compareTo(objectB.dateModified);
        break;
      case LeadFields.email:
        response = objectA.email.compareTo(objectB.email);
        break;
//      case LeadFields.last_activity:
//        response = objectA.lastActivity.compareTo(objectB.lastActivity);
//        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return objectA.firstName.compareTo(objectB.firstName);
    } else {
      return response;
    }
  }

  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    search = search.toLowerCase();

    // STARTER: search - do not remove comment
    if (firstName.toLowerCase().contains(search)) {
      return true;
    }
    if (lastName.toLowerCase().contains(search)) {
      return true;
    }
    if (cellPhone.raw().toLowerCase().contains(search)) {
      return true;
    }
    if (homePhone.raw().toLowerCase().contains(search)) {
      return true;
    }
    if (officePhone.raw().toLowerCase().contains(search)) {
      return true;
    }
    if (email.toLowerCase().contains(search)) {
      return true;
    }
    if (dateCreated.toString().toLowerCase().contains(search)) {
      return true;
    }
    if (dateModified.toLowerCase().contains(search)) {
      return true;
    }
//    if (lastActivity.toLowerCase().contains(search)) {
//      return true;
//    }
    return false;
  }

  String get displayName {
    // STARTER: display name - do not remove comment
    return "$lastName, $firstName";
  }

  @override
  String toString() {
    var _result = id.toString();
    return _result.toString();
  }
}
