// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactRow _$ContactRowFromJson(Map<String, dynamic> json) {
  return ContactRow(
      id: json['Contact_ID'] as String,
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
      dateCreated: json['Date_Created'] == null
          ? null
          : DateTime.parse(json['Date_Created'] as String),
      dateModified: json['Date_Modified'] == null
          ? null
          : DateTime.parse(json['Date_Modified'] as String),
      email: json['Email_Address'] as String);
}

Map<String, dynamic> _$ContactRowToJson(ContactRow instance) =>
    <String, dynamic>{
      'Contact_ID': instance.id,
      'First_Name': instance.firstName,
      'Last_Name': instance.lastName,
      'Cell_Phone': instance.cellPhone,
      'Office_Phone': instance.officePhone,
      'Home_Phone': instance.homePhone,
      'Date_Created': instance.dateCreated?.toIso8601String(),
      'Date_Modified': instance.dateModified?.toIso8601String(),
      'Email_Address': instance.email
    };
