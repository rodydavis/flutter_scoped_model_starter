// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Phone _$PhoneFromJson(Map<String, dynamic> json) {
  return Phone(
      label: json['label'] as String,
      areaCode: json['area_code'] as String,
      ext: json['ext'] as String,
      number: json['number'] as String,
      prefix: json['prefix'] as String);
}

Map<String, dynamic> _$PhoneToJson(Phone instance) => <String, dynamic>{
      'label': instance.label,
      'area_code': instance.areaCode,
      'prefix': instance.prefix,
      'number': instance.number,
      'ext': instance.ext
    };
