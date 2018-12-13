import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

@JsonSerializable()
class ThemeInfo {
  ThemeInfo({this.darkMode, this.trueBlack, this.isLoaded});

  bool darkMode;
  bool trueBlack;
  bool isLoaded;
  
  factory ThemeInfo.fromJson(Map<String, dynamic> json) =>
      _$ThemeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeInfoToJson(this);
}
