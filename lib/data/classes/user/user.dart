import 'package:json_annotation/json_annotation.dart';

import '../general/phone.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
    this.userId,
    this.fullName,
    this.firstName,
    this.lastName,
    this.email,
    this.title,
    this.licenseNumber,
    this.losLicenseInfo,
    this.companyImageUrl,
    this.profileImageUrl,
    this.phones,
    this.companyId,
    this.kalturaId,
    this.kalturaTags,
  );

  String userId;
  String fullName;
  String firstName;
  String lastName;
  String email;
  String title;
  String licenseNumber;
  String losLicenseInfo;
  String companyImageUrl;
  String profileImageUrl;
  List<Phone> phones;
  String companyId;
  String kalturaId;
  List<String> kalturaTags;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
