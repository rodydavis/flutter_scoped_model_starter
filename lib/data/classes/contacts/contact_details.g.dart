// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactDetails _$ContactDetailsFromJson(Map<String, dynamic> json) {
  return ContactDetails(
      firstName: json['First_Name'] as String,
      lastName: json['Last_Name'] as String,
      email: json['Email_Address'] as String,
      address: json['Address'] == null
          ? null
          : Address.fromJson(json['Address'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ContactDetailsToJson(ContactDetails instance) =>
    <String, dynamic>{
      'First_Name': instance.firstName,
      'Last_Name': instance.lastName,
      'Email_Address': instance.email,
      'Address': instance.address
    };
