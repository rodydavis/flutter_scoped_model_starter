// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) {
  return AppSettings(
      darkMode: json['darkMode'] as bool,
      trueBlack: json['trueBlack'] as bool,
      isLoaded: json['isLoaded'] as bool);
}

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'darkMode': instance.darkMode,
      'trueBlack': instance.trueBlack,
      'isLoaded': instance.isLoaded
    };
