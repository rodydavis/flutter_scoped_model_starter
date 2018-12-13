import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ResponseMessage {
  ResponseMessage({this.status, this.message, this.result, this.id});

  String status;
  String message;
  String id;
  dynamic result;

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$ResponseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMessageToJson(this);
}
