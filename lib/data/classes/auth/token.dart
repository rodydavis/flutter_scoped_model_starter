import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class TokenResponse {
  TokenResponse({
    this.token,
    this.expires = 0,
  });

  @JsonKey(name: 'access_token')
  String token;

  @JsonKey(name: 'expires_in')
  int expires;

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);
}
