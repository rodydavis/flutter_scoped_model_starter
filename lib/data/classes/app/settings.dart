import 'package:json_annotation/json_annotation.dart';

part 'settings.g.dart';

@JsonSerializable()
class AppSettings {
  AppSettings({
    this.darkMode = false,
    this.trueBlack = false,
    this.isLoaded = false,
  });

  bool darkMode;
  bool trueBlack;
  bool isLoaded;

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);
}
