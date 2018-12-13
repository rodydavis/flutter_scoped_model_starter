import 'package:json_annotation/json_annotation.dart';
// import '../../models/contact/fields.dart';

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
  static const String last_activity = 'Last Activity';
}

@JsonSerializable()
class ContactRow {
  ContactRow(
      {this.id,
      this.firstName,
      this.lastName,
      this.cellPhone,
      this.officePhone,
      this.homePhone,
      this.dateCreated,
      this.dateModified,
      this.email,
      this.lastActivity});

  String id;
  String firstName;
  String lastName;
  String cellPhone;
  String officePhone;
  String homePhone;
  String dateCreated;
  String dateModified;
  String email;
  String lastActivity;

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
        response = objectA.cellPhone.compareTo(objectB.cellPhone);
        break;
      case ContactFields.office_phone:
        response = objectA.officePhone.compareTo(objectB.officePhone);
        break;
      case ContactFields.home_phone:
        response = objectA.homePhone.compareTo(objectB.homePhone);
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
      case ContactFields.last_activity:
        response = objectA.lastActivity.compareTo(objectB.lastActivity);
        break;
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
    if (cellPhone.toLowerCase().contains(search)) {
      return true;
    }
    if (homePhone.toLowerCase().contains(search)) {
      return true;
    }
    if (officePhone.toLowerCase().contains(search)) {
      return true;
    }
    if (email.toLowerCase().contains(search)) {
      return true;
    }
    if (lastActivity.toLowerCase().contains(search)) {
      return true;
    }
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
