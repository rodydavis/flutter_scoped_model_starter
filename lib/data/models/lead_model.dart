import 'package:scoped_model/scoped_model.dart';
import '../classes/app/sort.dart';

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
    print(value);
    notifyListeners();
  }

  // -- Sort --
  Sort _sort = Sort(
    initialized: true,
    ascending: true,
    field: "",
    defaultField: "Last Name",
    fields: [
      "Last_Name",
      "First_Name",
    ],
  );

  Sort get sort => _sort;

  void sortChanged(Sort value) {
    _sort = value;
    notifyListeners();
  }

  // void sortOrderPressed() {
  //   _sort.ascending = !_sort.ascending;
  //   notifyListeners();
  // }

  // void sortFieldChanged(String value) {
  //   _sort.field = value;
  //   notifyListeners();
  // }
}
