import 'package:json_annotation/json_annotation.dart';

part 'theme.g.dart';

@JsonSerializable()
class ThemeModule {
  ThemeModule({
    this.darkMode = false,
    this.trueBlack = false,
    this.isLoaded = false,
  });

  bool darkMode;
  bool trueBlack;
  bool isLoaded;

  factory ThemeModule.fromJson(Map<String, dynamic> json) =>
      _$ThemeModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ThemeModuleToJson(this);
}
