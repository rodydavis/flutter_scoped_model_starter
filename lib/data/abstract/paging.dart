import '../classes/app/paging.dart';

abstract class Pager {
  int _total;
  int _pages;

  int get total => _total;
  int get pages => _pages;

  Paging _paging;

  Paging get paging => _paging;

  Future fetchNext() async {}

  Future fetchPage(int value) async {}
}
