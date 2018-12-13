// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['userId'] as String,
      json['fullName'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['title'] as String,
      json['licenseNumber'] as String,
      json['losLicenseInfo'] as String,
      json['companyImageUrl'] as String,
      json['profileImageUrl'] as String,
      (json['phones'] as List)
          ?.map((e) =>
              e == null ? null : Phone.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['companyId'] as String,
      json['kalturaId'] as String,
      (json['kalturaTags'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'fullName': instance.fullName,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'title': instance.title,
      'licenseNumber': instance.licenseNumber,
      'losLicenseInfo': instance.losLicenseInfo,
      'companyImageUrl': instance.companyImageUrl,
      'profileImageUrl': instance.profileImageUrl,
      'phones': instance.phones,
      'companyId': instance.companyId,
      'kalturaId': instance.kalturaId,
      'kalturaTags': instance.kalturaTags
    };
