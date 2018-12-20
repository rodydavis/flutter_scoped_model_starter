import '../../repositories/contacts/contacts.dart';
import '../auth_model.dart';
import 'package:contacts_service/contacts_service.dart';
import '../../../constants.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';
import '../../classes/contacts/contact_details.dart';
import 'list.dart';

class ContactDetailsModel extends Model {
  final String id;
  final AuthModel auth;

  ContactDetailsModel({this.id, @required this.auth});

  String _error = "";
  String get error => _error;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  bool _fetching = false;

  bool get fetching => _fetching;

  ContactDetails _details;

  ContactDetails get details => _details;

  Future import(Contact value) async {
    _fetching = true;
    notifyListeners();

    var _info = ContactDetails.fromPhoneContact(value);
    var _result = await ContactRepository().saveData(auth, contact: _info);
    if (_result) {
//      refresh();
    }

    _fetching = false;
    notifyListeners();
  }

  Future add(ContactDetails value) async {
    _fetching = true;
    notifyListeners();

    try {
      var _result = await ContactRepository().saveData(auth, contact: value);
      if (_result) {
//        refresh();
        _error = "";
      } else {
        _error = "Error Creating Contact";
      }
    } catch (e) {
      if (devMode) {
        _error = e;
      } else {
        _error = "Error Creating Contact (2)";
      }
    }

    _fetching = false;
    notifyListeners();
  }

  Future edit(ContactDetails value) async {
    _fetching = true;
    notifyListeners();

    try {
      var _result =
          await ContactRepository().saveData(auth, id: id, contact: value);
      if (_result) {
        _details = value;
//        refresh();
        _error = "";
      } else {
        _error = "Error Saving Contact";
      }
    } catch (e) {
      if (devMode) {
        _error = e;
      } else {
        _error = "Error Saving Contact (2)";
      }
    }

    _fetching = false;
    notifyListeners();
  }

  Future delete() async {
    _fetching = true;
    notifyListeners();

    try {
      var _result = await ContactRepository().deleteContact(auth, id: id);
      if (_result) {
//        refresh();
        _error = "";
      } else {
        _error = "Error Deleting Contact";
      }
    } catch (e) {
      if (devMode) {
        _error = e;
      } else {
        _error = "Error Deleting Contact (2)";
      }
    }

    _fetching = false;
    notifyListeners();
  }

  Future loadData() async {
    await _getDetails();
  }

  Future _getDetails() async {
    _isLoaded = false;

    notifyListeners();
    if (!_fetching) {
      _fetching = true;
      var _result = await ContactRepository().getInfo(auth, id: id);
      try {
        var _info = ContactDetails.fromJson(_result?.result);
        if (_info != null) _details = _info;
      } catch (e) {
        if (devMode) _error = e;
      }

      _fetching = false;
    }
    _isLoaded = true;
    notifyListeners();
  }

  void cancel() {
    _fetching = false;
    notifyListeners();
  }
}
