import 'package:json_annotation/json_annotation.dart';

part 'company_category.g.dart';

@JsonSerializable()
class CompanyCategory {
  CompanyCategory({this.name, this.order});

  String name;
  int order;

  factory CompanyCategory.fromJson(Map<String, dynamic> json) =>
      _$CompanyCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyCategoryToJson(this);
}
