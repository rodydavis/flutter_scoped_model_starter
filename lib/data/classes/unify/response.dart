import 'package:json_annotation/json_annotation.dart';

part 'response.g.dart';

@JsonSerializable()
class ResponseMessage {
  ResponseMessage({
    this.status,
    this.message,
    this.result,
  });

  @JsonKey(name: 'Status')
  String status;
  @JsonKey(name: 'Message')
  String message;
  @JsonKey(name: 'Result')
  dynamic result;

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$ResponseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMessageToJson(this);
}
