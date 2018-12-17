import 'package:json_annotation/json_annotation.dart';

part 'contact_group.g.dart';

@JsonSerializable()
class ContactGroup {
  ContactGroup({this.id, this.name});

  @JsonKey(nullable: true)
  String id;
  String name;

  factory ContactGroup.fromJson(Map<String, dynamic> json) =>
      _$ContactGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ContactGroupToJson(this);
}
