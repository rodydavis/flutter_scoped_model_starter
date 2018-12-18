import 'package:scoped_model/scoped_model.dart';

class LeadModel extends Model {
  String get title => "Leads";

  // -- Search --
  String _searchValue = "";
  bool _isSearching = false;

  String get searchValue => _searchValue;
  bool get isSearching => _isSearching;

  void searchPressed() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void searchChanged(String value) {
    _searchValue = value;
    notifyListeners();
  }
}
