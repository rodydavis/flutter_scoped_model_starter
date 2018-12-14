import 'package:json_annotation/json_annotation.dart';
// import '../../models/contact/fields.dart';
import '../general/phone.dart';
part 'contact_row.g.dart';


class ContactFields {
  static const String id = 'ID';
  static const String objectType = "Contact";
  // STARTER: fields - do not remove comment
  static const String first_name = 'First Name';
  static const String last_name = 'Last Name';
  static const String cell_phone = 'Cell Phone';
  static const String office_phone = 'Office Phone';
  static const String home_phone = 'Home Phone';
  static const String date_created = 'Date Created';
  static const String date_modified = 'Date Modified';
  static const String email = 'Email Address';
  // static const String last_activity = 'Last Activity';
}

@JsonSerializable()
class ContactRow {
  ContactRow({
    this.id,
    this.firstName,
    this.lastName,
    this.cellPhone,
    this.officePhone,
    this.homePhone,
    this.dateCreated,
    this.dateModified,
    this.email,
    // this.lastActivity,
  });

  @JsonKey(name: 'Contact_ID')
  String id;
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
  // @JsonKey(name: 'last_activity')
  // String lastActivity;

  factory ContactRow.fromJson(Map<String, dynamic> json) =>
      _$ContactRowFromJson(json);

  Map<String, dynamic> toJson() => _$ContactRowToJson(this);

  int compareTo(ContactRow object, String sortField, bool sortAscending) {
    int response = 0;
    ContactRow objectA = sortAscending ? this : object;
    ContactRow objectB = sortAscending ? object : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case ContactFields.first_name:
        response = objectA.firstName.compareTo(objectB.firstName);
        break;
      case ContactFields.last_name:
        response = objectA.lastName.compareTo(objectB.lastName);
        break;
      case ContactFields.cell_phone:
        response = objectA.cellPhone.raw().compareTo(objectB.cellPhone.raw());
        break;
      case ContactFields.office_phone:
        response = objectA.officePhone.raw().compareTo(objectB.officePhone.raw());
        break;
      case ContactFields.home_phone:
        response = objectA.homePhone.raw().compareTo(objectB.homePhone.raw());
        break;
      case ContactFields.date_created:
        response = objectA.dateCreated.compareTo(objectB.dateCreated);
        break;
      case ContactFields.date_modified:
        response = objectA.dateModified.compareTo(objectB.dateModified);
        break;
      case ContactFields.email:
        response = objectA.email.compareTo(objectB.email);
        break;
      // case ContactFields.last_activity:
      //   response = objectA.lastActivity.compareTo(objectB.lastActivity);
      //   break;
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
    // if (lastActivity.toLowerCase().contains(search)) {
    //   return true;
    // }
    if (dateCreated.toLowerCase().contains(search)) {
      return true;
    }
    if (dateModified.toLowerCase().contains(search)) {
      return true;
    }
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
