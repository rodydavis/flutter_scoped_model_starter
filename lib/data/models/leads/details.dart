import '../../classes/leads/lead_details.dart';
import '../../repositories/leads/details.dart';
import '../auth_model.dart';
import 'list.dart';

class LeadDetailsModel extends LeadModel {
  final String id;
  final AuthModel authModel;

  LeadDetailsModel({this.id, this.authModel});

  String _error = "";
  String get error => _error;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  LeadDetails _details;

  LeadDetails get details => _details;

  Future add(LeadDetails value) async {
    var _result =
        await LeadDetailsRepository().saveLead(authModel, lead: value);
    if (_result) {
      refresh();
    }
    notifyListeners();
  }

  Future edit(LeadDetails value) async {
    var _result =
        await LeadDetailsRepository().saveLead(authModel, id: id, lead: value);
    if (_result) {
      _details = value;
      refresh();
    }
    notifyListeners();
  }

  Future delete() async {
    var _result = await LeadDetailsRepository().deleteLead(authModel, id: id);
    if (_result) {
      refresh();
    }
    notifyListeners();
  }

  Future loadData() async {
    await _getDetails();
  }

  bool _fetching = false;
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
        print(e);
        _error = e;
      }
      _isLoaded = true;
      _fetching = false;
    }

    notifyListeners();
  }
}
