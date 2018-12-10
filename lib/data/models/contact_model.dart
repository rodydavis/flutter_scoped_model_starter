import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../models/auth/model.dart';
import '../models/paging_model.dart';
import '../repositories/contact_repository.dart';
import 'general/address.dart';
import 'general/company_category.dart';
import 'general/contact_groups.dart';
import 'general/phones.dart';

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

class ContactModel extends Model {
  // -- Paging --
  PagingModel _paging = PagingModel(rows: 100, page: 1);

  void nextPage(BuildContext context) {
    _paging = PagingModel(
      rows: _paging.rows,
      page: _paging.page + 1,
    );
    loadItems(context);
    notifyListeners();
  }

  void refresh(BuildContext context) {
    _paging = PagingModel(
      rows: _paging.rows,
      page: _paging.page,
    );
    loadItems(context);
    notifyListeners();
  }

  bool _loaded = false;
  int _lastUpdated = 0;

  List<ContactObject> _items = [];
  List<ContactObject> _filtered = [];

  int get lastUpdated => _lastUpdated;

  bool get isLoaded {
    if (isStale) return false;
    return _loaded;
  }

  bool get isStale {
    // if (!isLoaded) return true;
    if (lastUpdated == 0) return true;
    try {
      return DateTime.now().millisecondsSinceEpoch - lastUpdated >
          kMillisecondsToRefreshData;
    } catch (e) {
      print(e);
      return true;
    }
    // return false;
  }

  set loaded(bool value) {
    _loaded = true;
    notifyListeners();
  }

  List<ContactObject> get items => _items;
  List<ContactObject> get filteredItems => _filtered;

  Future<bool> loadItems(BuildContext context) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    // -- Load Items from API or Local --
    var _contacts = await ContactRepository().loadList(_auth, paging: _paging);
    _items = _contacts;
    _lastUpdated = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
    return true;
  }

  void addItem(ContactObject item) {
    print("Adding Item => ${item?.id}");
    _items.add(item);
    notifyListeners();
  }

  void removeItem(ContactObject item) {
    print("Removing Item => ${item?.id}");
    _items.remove(item);
    notifyListeners();
  }

  void editItem(ContactObject item) {
    print("Editing Item => ${item?.id}");
    if (items.isNotEmpty)
      for (var _item in items) {
        if (_item.id == item.id) {
          _items.remove(_item);
          _items.add(item);
        }
      }
    notifyListeners();
  }

  void sort(String field, bool ascending) {
    _items.sort((a, b) => a.compareTo(b, field, ascending));
    notifyListeners();
  }

  void search(String value) {
    print("Searching... $value");

    List<ContactObject> _results = [];

    for (var _item in items) {
      if (_item.matchesSearch(value)) {
        _results.add(_item);
      }
    }

    _filtered = _results;
    notifyListeners();
  }

  void startSearching() {
    _filtered = _items;
    notifyListeners();
  }

  void stopSearching(BuildContext context) {
    loadItems(context);
    notifyListeners();
  }
}

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


