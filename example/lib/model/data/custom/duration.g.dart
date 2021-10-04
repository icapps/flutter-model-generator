// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Duration _$DurationFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['test'],
  );
  return Duration(
    test: json['test'] as String,
  );
}

Map<String, dynamic> _$DurationToJson(Duration instance) => <String, dynamic>{
      'test': instance.test,
    };
