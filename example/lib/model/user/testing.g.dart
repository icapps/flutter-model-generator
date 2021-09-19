// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Testing _$TestingFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['beneficiary'],
  );
  return Testing(
    beneficiary: json['beneficiary'] as String,
    structuredMessage: json['structuredMessage'] as String?,
    beneficiaryIBAN: json['beneficiaryIBAN'] as String?,
    dynamicField: json['dynamicField'],
    duration: json['duration'] == null
        ? null
        : Duration.fromJson(json['duration'] as Map<String, dynamic>),
    durationFromJsonTest:
        handleDurationFromToJsonFromJson(json['duration_from_json_test']),
  );
}

Map<String, dynamic> _$TestingToJson(Testing instance) {
  final val = <String, dynamic>{
    'beneficiary': instance.beneficiary,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('structuredMessage', instance.structuredMessage);
  writeNotNull('beneficiaryIBAN', instance.beneficiaryIBAN);
  writeNotNull('dynamicField', instance.dynamicField);
  writeNotNull('duration', instance.duration?.toJson());
  writeNotNull('duration_from_json_test',
      handleDurationFromToJsonToJson(instance.durationFromJsonTest));
  return val;
}
