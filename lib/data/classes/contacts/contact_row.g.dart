// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactRow _$ContactRowFromJson(Map<String, dynamic> json) {
  return ContactRow(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      cellPhone: json['cell_phone'] as String,
      officePhone: json['office_phone'] as String,
      homePhone: json['home_phone'] as String,
      dateCreated: json['date_created'] as String,
      dateModified: json['date_modified'] as String,
      email: json['email'] as String,
      lastActivity: json['last_activity'] as String);
}

Map<String, dynamic> _$ContactRowToJson(ContactRow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'cell_phone': instance.cellPhone,
      'office_phone': instance.officePhone,
      'home_phone': instance.homePhone,
      'date_created': instance.dateCreated,
      'date_modified': instance.dateModified,
      'email': instance.email,
      'last_activity': instance.lastActivity
    };
