import 'fields.dart';

class ContactResult {
  String status;
  String message;
  List<ContactObject> result;

  ContactResult({this.status, this.message, this.result});

  ContactResult.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Result'] != null) {
      result = new List<ContactObject>();
      json['Result'].forEach((v) {
        result.add(new ContactObject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.result != null) {
      data['Result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactObject {
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

  ContactObject(
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

  ContactObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    cellPhone = json['cell_phone'];
    officePhone = json['office_phone'];
    homePhone = json['home_phone'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    email = json['email'];
    lastActivity = json['last_activity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['cell_phone'] = this.cellPhone;
    data['office_phone'] = this.officePhone;
    data['home_phone'] = this.homePhone;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['email'] = this.email;
    data['last_activity'] = this.lastActivity;
    return data;
  }

  int compareTo(ContactObject object, String sortField, bool sortAscending) {
    int response = 0;
    ContactObject objectA = sortAscending ? this : object;
    ContactObject objectB = sortAscending ? object : this;

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

