import '../../classes/leads/lead_details.dart';
import '../../repositories/leads/leads.dart';
import '../auth_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:contacts_service/contacts_service.dart';
import '../../../constants.dart';
import 'package:flutter/foundation.dart';

class LeadDetailsModel extends Model {
  final String id;
  final AuthModel auth;

  LeadDetailsModel({this.id, @required this.auth});

  String _error = "";
  String get error => _error;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  bool _fetching = false;

  bool get fetching => _fetching;

  LeadDetails _details;

  LeadDetails get details => _details;

  Future import(Contact value) async {
    _fetching = true;
    notifyListeners();

    var _lead = LeadDetails.fromPhoneContact(value);
    var _result = await LeadRepository().saveLead(auth, lead: _lead);
    if (_result) {
//      refresh();
    }

    _fetching = false;
    notifyListeners();
  }

  Future add(LeadDetails value) async {
    _fetching = true;
    notifyListeners();

    try {
      var _result = await LeadRepository().saveLead(auth, lead: value);
      if (_result) {
//        refresh();
        _error = "";
      } else {
        _error = "Error Creating Lead";
      }
    } catch (e) {
      if (devMode) {
        _error = e;
      } else {
        _error = "Error Creating Lead (2)";
      }
    }

    _fetching = false;
    notifyListeners();
  }

  Future edit(LeadDetails value) async {
    _fetching = true;
    notifyListeners();

    try {
      var _result = await LeadRepository().saveLead(auth, id: id, lead: value);
      if (_result) {
        _details = value;
//        refresh();
        _error = "";
      } else {
        _error = "Error Saving Lead";
      }
    } catch (e) {
      if (devMode) {
        _error = e;
      } else {
        _error = "Error Saving Lead (2)";
      }
    }

    _fetching = false;
    notifyListeners();
  }

  Future delete() async {
    _fetching = true;
    notifyListeners();

    try {
      var _result = await LeadRepository().deleteLead(auth, id: id);
      if (_result) {
//        refresh();
        _error = "";
      } else {
        _error = "Error Deleting Lead";
      }
    } catch (e) {
      if (devMode) {
        _error = e;
      } else {
        _error = "Error Deleting Lead (2)";
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
      var _result = await LeadRepository().getLead(auth, id: id);
      try {
        var _info = LeadDetails.fromJson(_result?.result);
        if (_info != null) _details = _info;
      } catch (e) {
        if (devMode) _error = e;
      }
      _isLoaded = true;
      _fetching = false;
    }

    notifyListeners();
  }

  void cancel() {
    _fetching = false;
    notifyListeners();
  }
}
