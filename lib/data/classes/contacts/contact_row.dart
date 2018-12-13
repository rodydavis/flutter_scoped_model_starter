import 'package:json_annotation/json_annotation.dart';

part 'contact_row.g.dart';

@JsonSerializable()
class ContactRow {
  ContactRow(
      {this.id,
      this.firstName,
      this.lastName,
      this.cellPhone,
      this.officePhone,
      this.homePhone,
      this.dateCreated,
      this.dateModified,
      this.email,
      this.lastActivity});

  String id;
  String firstName;
  String lastName;
  String cellPhone;
  String officePhone;
  String homePhone;
  String dateCreated;
  String dateModified;
  String email;
  String lastActivity;

  factory ContactRow.fromJson(Map<String, dynamic> json) =>
      _$ContactRowFromJson(json);

  Map<String, dynamic> toJson() => _$ContactRowToJson(this);
}
