// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactRow _$ContactRowFromJson(Map<String, dynamic> json) {
  return ContactRow(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      cellPhone: json['cellPhone'] as String,
      officePhone: json['officePhone'] as String,
      homePhone: json['homePhone'] as String,
      dateCreated: json['dateCreated'] as String,
      dateModified: json['dateModified'] as String,
      email: json['email'] as String,
      lastActivity: json['lastActivity'] as String);
}

Map<String, dynamic> _$ContactRowToJson(ContactRow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'cellPhone': instance.cellPhone,
      'officePhone': instance.officePhone,
      'homePhone': instance.homePhone,
      'dateCreated': instance.dateCreated,
      'dateModified': instance.dateModified,
      'email': instance.email,
      'lastActivity': instance.lastActivity
    };
