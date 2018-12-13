import 'package:json_annotation/json_annotation.dart';

part 'paging.g.dart';

@JsonSerializable()
class Paging {
  Paging({this.rows, this.page});

  int rows;
  int page;

  factory Paging.fromJson(Map<String, dynamic> json) =>
      _$PagingFromJson(json);

  Map<String, dynamic> toJson() => _$PagingToJson(this);
}
