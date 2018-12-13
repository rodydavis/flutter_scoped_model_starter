import 'package:json_annotation/json_annotation.dart';

import '../general/search.dart';
import '../general/sort.dart';
import 'contact_row.dart';
import '../general/paging.dart';

part 'contact_module.g.dart';

@JsonSerializable()
class ContactModule {
  ContactModule({
    this.paging,
    this.lastPage,
    this.contacts,
    this.filtered,
    this.lastUpdated,
    this.isLoaded,
    this.search,
    this.sorting,
  });

  Paging paging;
  bool lastPage;
  List<ContactRow> contacts;
  List<ContactRow> filtered;
  bool isLoaded;
  int lastUpdated;
  Sort sorting;
  Search search;

  factory ContactModule.fromJson(Map<String, dynamic> json) =>
      _$ContactModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ContactModuleToJson(this);
}
