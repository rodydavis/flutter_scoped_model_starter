// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetails _$ContactDetailsFromJson(Map<String, dynamic> json) {
  return ContactDetails(
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      phones: (json['phones'] as List)
          ?.map((e) =>
              e == null ? null : Phone.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      birthdate: json['birthdate'] as String,
      integrationId: json['integration_id'] as String,
      companyCategory: json['company_category'] == null
          ? null
          : CompanyCategory.fromJson(
              json['company_category'] as Map<String, dynamic>),
      contactGroups: (json['contact_groups'] as List)
          ?.map((e) => e == null
              ? null
              : ContactGroup.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ContactDetailsToJson(ContactDetails instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'middle_name': instance.middleName,
      'last_name': instance.lastName,
      'email': instance.email,
      'address': instance.address,
      'phones': instance.phones,
      'birthdate': instance.birthdate,
      'integration_id': instance.integrationId,
      'company_category': instance.companyCategory,
      'contact_groups': instance.contactGroups
    };
