import '../../classes/leads/lead_details.dart';
import '../../repositories/leads/details.dart';
import '../auth_model.dart';
import 'list.dart';
import 'package:contacts_service/contacts_service.dart';
import '../../../constants.dart';

class LeadDetailsModel extends LeadModel {
  final String id;
  final AuthModel authModel;

  LeadDetailsModel({this.id, this.authModel});

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
    var _result =
        await LeadDetailsRepository().saveLead(authModel, lead: _lead);
    if (_result) {
      refresh();
    }

    _fetching = false;
    notifyListeners();
  }

  Future add(LeadDetails value) async {
    _fetching = true;
    notifyListeners();

    try {
      var _result =
          await LeadDetailsRepository().saveLead(authModel, lead: value);
      if (_result) {
        refresh();
        _error = "";
      } else {
        _error = "Error Creating Lead";
      }
    } catch (e) {
      if (devMode) _error = e;
    }

    _fetching = false;
    notifyListeners();
  }

  Future edit(LeadDetails value) async {
    _fetching = true;
    notifyListeners();

    try {
      var _result = await LeadDetailsRepository()
          .saveLead(authModel, id: id, lead: value);
      if (_result) {
        _details = value;
        refresh();
        _error = "";
      } else {
        _error = "Error Saving Lead";
      }
    } catch (e) {
      if (devMode) _error = e;
    }

    _fetching = false;
    notifyListeners();
  }

  Future delete() async {
    _fetching = true;
    notifyListeners();

    try {
      var _result = await LeadDetailsRepository().deleteLead(authModel, id: id);
      if (_result) {
        refresh();
        _error = "";
      } else {
        _error = "Error Deleting Lead";
      }
    } catch (e) {
      if (devMode) _error = e;
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
      var _result = await LeadDetailsRepository().getLead(authModel, id: id);
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
}
