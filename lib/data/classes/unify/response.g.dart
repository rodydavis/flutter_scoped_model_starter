// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMessage _$ResponseMessageFromJson(Map<String, dynamic> json) {
  return ResponseMessage(
      status: json['Status'] as String,
      message: json['Message'] as String,
      result: json['Result']);
}

Map<String, dynamic> _$ResponseMessageToJson(ResponseMessage instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Result': instance.result
    };
