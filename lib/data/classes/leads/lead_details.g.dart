// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadDetails _$LeadDetailsFromJson(Map<String, dynamic> json) {
  return LeadDetails(
      firstName: json['First_Name'] as String,
      lastName: json['Last_Name'] as String,
      email: json['Email_Address'] as String,
      currentAddress: json['Current_Address'] == null
          ? null
          : Address.fromJson(json['Current_Address'] as Map<String, dynamic>),
      propertyAddress: json['Property_Address'] == null
          ? null
          : Address.fromJson(json['Property_Address'] as Map<String, dynamic>),
      homePhone: json['Home_Phone'] == null
          ? null
          : Phone.fromJson(json['Home_Phone'] as Map<String, dynamic>),
      cellPhone: json['Cell_Phone'] == null
          ? null
          : Phone.fromJson(json['Cell_Phone'] as Map<String, dynamic>),
      officePhone: json['Office_Phone'] == null
          ? null
          : Phone.fromJson(json['Office_Phone'] as Map<String, dynamic>),
      leadGroups: (json['Lead_Groups'] as List)
          ?.map((e) => e == null
              ? null
              : ContactGroup.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      dateModified: json['Date_Modified'] as String,
      dateCreated: json['Date_Created'] as String);
}

Map<String, dynamic> _$LeadDetailsToJson(LeadDetails instance) =>
    <String, dynamic>{
      'First_Name': instance.firstName,
      'Last_Name': instance.lastName,
      'Email_Address': instance.email,
      'Current_Address': instance.currentAddress,
      'Property_Address': instance.propertyAddress,
      'Cell_Phone': instance.cellPhone,
      'Office_Phone': instance.officePhone,
      'Home_Phone': instance.homePhone,
      'Date_Created': instance.dateCreated,
      'Date_Modified': instance.dateModified,
      'Lead_Groups': instance.leadGroups
    };
