import 'package:json_annotation/json_annotation.dart';

part 'sort.g.dart';

@JsonSerializable()
class Sort {
  Sort({this.defaultField, this.fields, this.ascending, this.field});

  String defaultField;
  List<String> fields;
  bool ascending;
  String field;

  factory Sort.fromJson(Map<String, dynamic> json) => _$SortFromJson(json);

  Map<String, dynamic> toJson() => _$SortToJson(this);
}
