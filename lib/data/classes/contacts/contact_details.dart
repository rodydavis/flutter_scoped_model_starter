import 'package:json_annotation/json_annotation.dart';

import '../general/address.dart';
import '../general/phone.dart';
import '../unify/company_category.dart';
import '../unify/contact_group.dart';

part 'contact_details.g.dart';

@JsonSerializable()
class ContactDetails {
  ContactDetails(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.address,
      this.phones,
      this.birthdate,
      this.integrationId,
      this.companyCategory,
      this.contactGroups});

  String firstName;
  String middleName;
  String lastName;
  String email;
  Address address;
  List<Phone> phones;
  String birthdate;
  String integrationId;
  CompanyCategory companyCategory;
  List<ContactGroup> contactGroups;

  factory ContactDetails.fromJson(Map<String, dynamic> json) =>
      _$ContactDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDetailsToJson(this);
}
