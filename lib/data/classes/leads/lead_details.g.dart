// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadDetails _$LeadDetailsFromJson(Map<String, dynamic> json) {
  return LeadDetails(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      currentAddress: json['current_address'] == null
          ? null
          : Address.fromJson(json['current_address'] as Map<String, dynamic>),
      propertyAddress: json['property_address'] == null
          ? null
          : Address.fromJson(json['property_address'] as Map<String, dynamic>),
      homePhone: json['home_phone'] == null
          ? null
          : Phone.fromJson(json['home_phone'] as Map<String, dynamic>),
      cellPhone: json['cell_phone'] == null
          ? null
          : Phone.fromJson(json['cell_phone'] as Map<String, dynamic>),
      officePhone: json['office_phone'] == null
          ? null
          : Phone.fromJson(json['office_phone'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LeadDetailsToJson(LeadDetails instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'current_address': instance.currentAddress,
      'property_address': instance.propertyAddress,
      'cell_phone': instance.cellPhone,
      'office_phone': instance.officePhone,
      'home_phone': instance.homePhone
    };
