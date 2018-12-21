// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadRow _$LeadRowFromJson(Map<String, dynamic> json) {
  return LeadRow(
      id: json['Lead_ID'] as String,
      firstName: json['First_Name'] as String,
      lastName: json['Last_Name'] as String,
      cellPhone: json['Cell_Phone'] == null
          ? null
          : Phone.fromJson(json['Cell_Phone'] as Map<String, dynamic>),
      officePhone: json['Office_Phone'] == null
          ? null
          : Phone.fromJson(json['Office_Phone'] as Map<String, dynamic>),
      homePhone: json['Home_Phone'] == null
          ? null
          : Phone.fromJson(json['Home_Phone'] as Map<String, dynamic>),
      dateCreated: json['Date_Created'] as String,
      dateModified: json['Date_Modified'] as String,
      email: json['Email_Address'] as String,
      contactId: json['Contact_ID'] as String);
}

Map<String, dynamic> _$LeadRowToJson(LeadRow instance) => <String, dynamic>{
      'Lead_ID': instance.id,
      'Contact_ID': instance.contactId,
      'First_Name': instance.firstName,
      'Last_Name': instance.lastName,
      'Cell_Phone': instance.cellPhone,
      'Office_Phone': instance.officePhone,
      'Home_Phone': instance.homePhone,
      'Date_Created': instance.dateCreated,
      'Date_Modified': instance.dateModified,
      'Email_Address': instance.email
    };
