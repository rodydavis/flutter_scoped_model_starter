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

  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'full_name')
  String fullName;
  @JsonKey(name: 'first_name')
  String firstName;
  @JsonKey(name: 'last_name')
  String lastName;
  String email;
  String title;
  @JsonKey(name: 'license_number')
  String licenseNumber;
  @JsonKey(name: 'los_license_number')
  String losLicenseInfo;
  @JsonKey(name: 'company_image_url')
  String companyImageUrl;
  @JsonKey(name: 'profile_image_url')
  String profileImageUrl;
  List<Phone> phones;
  @JsonKey(name: 'company_id')
  String companyId;
  @JsonKey(name: 'kaltura_id')
  String kalturaId;
  @JsonKey(name: 'kaltura_tags')
  List<String> kalturaTags;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
