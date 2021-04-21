// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OGM _$OGMFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'structuredMessage',
    'beneficiary',
    'beneficiaryIBAN',
    'test_Test',
    'some_Thing',
    'some_ThinG_huGE'
  ]);
  return OGM(
    structuredMessage: json['structuredMessage'] as String,
    beneficiary: json['beneficiary'] as String,
    beneficiaryIBAN: json['beneficiaryIBAN'] as String,
    testTest: json['test_Test'] as String,
    someThing: json['some_Thing'] as String,
    someThinGHuGE: json['some_ThinG_huGE'] as String,
    securityRole: json['securityIndicator'] as String?,
    mutableProperty: json['mutableProperty'] as String?,
    dateChange: json['dateChange'] == null
        ? null
        : DateTime.parse(json['dateChange'] as String),
    fields: (json['fields'] as List<dynamic>?)
        ?.map((e) => (e as List<dynamic>)
            .map((e) => Testing.fromJson(e as Map<String, dynamic>))
            .toList())
        .toList(),
  );
}

Map<String, dynamic> _$OGMToJson(OGM instance) => <String, dynamic>{
      'structuredMessage': instance.structuredMessage,
      'beneficiary': instance.beneficiary,
      'beneficiaryIBAN': instance.beneficiaryIBAN,
      'test_Test': instance.testTest,
      'some_Thing': instance.someThing,
      'some_ThinG_huGE': instance.someThinGHuGE,
      'securityIndicator': instance.securityRole,
      'mutableProperty': instance.mutableProperty,
      'dateChange': instance.dateChange?.toIso8601String(),
      'fields': instance.fields,
    };
