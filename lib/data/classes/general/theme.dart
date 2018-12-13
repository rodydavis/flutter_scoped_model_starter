import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

@JsonSerializable()
class ThemeInfo {
  ThemeInfo({
    this.darkMode = false,
    this.trueBlack = false,
    this.isLoaded = false,
  });

  bool darkMode;
  bool trueBlack;
  bool isLoaded;

  factory ThemeInfo.fromJson(Map<String, dynamic> json) =>
      _$ThemeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeInfoToJson(this);
}
