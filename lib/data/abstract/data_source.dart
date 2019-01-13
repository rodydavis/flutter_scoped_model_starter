import 'remote_data.dart';
import 'query_model.dart';
import 'paging.dart';
import 'sorting.dart';
import 'item_selection.dart';

abstract class DataSource implements RemoteData, QueryModel, Sorting, Pager {
  int _lastUpdated;
  int get lastUpdated => _lastUpdated;

  bool get isStale => false;

  List _items;

  List get items => _items;

  @override
  Future load({bool nextPage = false, String query = ""}) async {}
}
