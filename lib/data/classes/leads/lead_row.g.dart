// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lead_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeadRow _$LeadRowFromJson(Map<String, dynamic> json) {
  return LeadRow(
      id: json['lead_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      cellPhone: json['cell_phone'] as String,
      officePhone: json['office_phone'] as String,
      homePhone: json['home_phone'] as String,
      dateCreated: json['date_created'] == null
          ? null
          : DateTime.parse(json['date_created'] as String),
      email: json['email'] as String,
      lastActivity: json['last_activity'] as String,
      contactId: json['contact_id'] as String);
}

Map<String, dynamic> _$LeadRowToJson(LeadRow instance) => <String, dynamic>{
      'lead_id': instance.id,
      'contact_id': instance.contactId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'cell_phone': instance.cellPhone,
      'office_phone': instance.officePhone,
      'home_phone': instance.homePhone,
      'date_created': instance.dateCreated?.toIso8601String(),
      'email': instance.email,
      'last_activity': instance.lastActivity
    };
