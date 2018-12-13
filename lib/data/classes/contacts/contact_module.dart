import 'package:json_annotation/json_annotation.dart';

import '../app/paging.dart';
import '../app/sort.dart';
import '../general/search.dart';
import 'contact_row.dart';

part 'contact_module.g.dart';

@JsonSerializable()
class ContactModule {
  ContactModule({
    this.paging,
    this.lastPage = false,
    this.contacts,
    this.filtered,
    this.lastUpdated = 0,
    this.isLoaded = false,
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
