// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OGM _$OGMFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'beneficiary',
      'beneficiaryIBAN',
      'test_Test',
      'some_Thing',
      'some_ThinG_huGE',
      'simpleFields'
    ],
  );
  return OGM(
    beneficiary: json['beneficiary'] as String,
    beneficiaryIBAN: json['beneficiaryIBAN'] as String,
    testTest: json['test_Test'] as String,
    someThing: json['some_Thing'] as String,
    someThinGHuGE: json['some_ThinG_huGE'] as String,
    simpleFields: (json['simpleFields'] as List<dynamic>)
        .map((e) => Testing.fromJson(e as Map<String, dynamic>))
        .toList(),
    structuredMessage: json['structuredMessage'] as String?,
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
    simpleMap: (json['simpleMap'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Testing.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$OGMToJson(OGM instance) {
  final val = <String, dynamic>{
    'beneficiary': instance.beneficiary,
    'beneficiaryIBAN': instance.beneficiaryIBAN,
    'test_Test': instance.testTest,
    'some_Thing': instance.someThing,
    'some_ThinG_huGE': instance.someThinGHuGE,
    'simpleFields': instance.simpleFields.map((e) => e.toJson()).toList(),
    'structuredMessage': instance.structuredMessage,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('securityIndicator', instance.securityRole);
  writeNotNull('mutableProperty', instance.mutableProperty);
  writeNotNull('dateChange', instance.dateChange?.toIso8601String());
  writeNotNull('fields',
      instance.fields?.map((e) => e.map((e) => e.toJson()).toList()).toList());
  val['simpleMap'] = instance.simpleMap?.map((k, e) => MapEntry(k, e.toJson()));
  return val;
}
