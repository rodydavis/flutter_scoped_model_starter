import '../classes/app/sort.dart';

abstract class Sorting {
  Sort _sort = Sort();

  Sort get sort => _sort;

  void sortChanged(Sort value) {}

  void sortList(String field, bool ascending) {}
}
