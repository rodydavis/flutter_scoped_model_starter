// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModule _$ContactModuleFromJson(Map<String, dynamic> json) {
  return ContactModule(
      street: json['street'] as String,
      apartment: json['apartment'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      zip: json['zip'] as String)
    ..county = json['county'] as String;
}

Map<String, dynamic> _$ContactModuleToJson(ContactModule instance) =>
    <String, dynamic>{
      'street': instance.street,
      'apartment': instance.apartment,
      'state': instance.state,
      'city': instance.city,
      'zip': instance.zip,
      'county': instance.county
    };
