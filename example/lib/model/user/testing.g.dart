// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Testing _$TestingFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['beneficiary']);
  return Testing(
    beneficiary: json['beneficiary'] as String,
    structuredMessage: json['structuredMessage'] as String,
    beneficiaryIBAN: json['beneficiaryIBAN'] as String,
    duration: json['duration'] == null
        ? null
        : Duration.fromJson(json['duration'] as Map<String, dynamic>),
    durationFromJsonTest:
        handleDurationFromToJsonFromJson(json['duration_from_json_test']),
  );
}

Map<String, dynamic> _$TestingToJson(Testing instance) => <String, dynamic>{
      'beneficiary': instance.beneficiary,
      'structuredMessage': instance.structuredMessage,
      'beneficiaryIBAN': instance.beneficiaryIBAN,
      'duration': instance.duration,
      'duration_from_json_test':
          handleDurationFromToJsonToJson(instance.durationFromJsonTest),
    };
