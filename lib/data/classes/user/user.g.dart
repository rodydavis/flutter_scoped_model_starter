// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['user_id'] as String,
      json['full_name'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['email'] as String,
      json['title'] as String,
      json['license_number'] as String,
      json['los_license_number'] as String,
      json['company_image_url'] as String,
      json['profile_image_url'] as String,
      (json['phones'] as List)
          ?.map((e) =>
              e == null ? null : Phone.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['company_id'] as String,
      json['kaltura_id'] as String,
      (json['kaltura_tags'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'title': instance.title,
      'license_number': instance.licenseNumber,
      'los_license_number': instance.losLicenseInfo,
      'company_image_url': instance.companyImageUrl,
      'profile_image_url': instance.profileImageUrl,
      'phones': instance.phones,
      'company_id': instance.companyId,
      'kaltura_id': instance.kalturaId,
      'kaltura_tags': instance.kalturaTags
    };
