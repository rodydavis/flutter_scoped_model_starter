// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMessage _$ResponseMessageFromJson(Map<String, dynamic> json) {
  return ResponseMessage(
      status: json['status'] as String,
      message: json['message'] as String,
      result: json['result'],
      id: json['id'] as String);
}

Map<String, dynamic> _$ResponseMessageToJson(ResponseMessage instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'id': instance.id,
      'result': instance.result
    };
