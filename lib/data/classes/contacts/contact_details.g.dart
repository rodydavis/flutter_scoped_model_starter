// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetails _$ContactDetailsFromJson(Map<String, dynamic> json) {
  return ContactDetails(
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phones: (json['phones'] as List)
          ?.map((e) =>
              e == null ? null : Phone.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      birthdate: json['birthdate'] as String,
      integrationId: json['integrationId'] as String,
      companyCategory: json['companyCategory'] == null
          ? null
          : CompanyCategory.fromJson(
              json['companyCategory'] as Map<String, dynamic>),
      contactGroups: (json['contactGroups'] as List)
          ?.map((e) => e == null
              ? null
              : ContactGroup.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ContactDetailsToJson(ContactDetails instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'middleName': instance.middleName,
      'lastName': instance.lastName,
      'email': instance.email,
      'address': instance.address,
      'phones': instance.phones,
      'birthdate': instance.birthdate,
      'integrationId': instance.integrationId,
      'companyCategory': instance.companyCategory,
      'contactGroups': instance.contactGroups
    };
