// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OGM _$OGMFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'structuredMessage',
    'beneficiary',
    'beneficiaryIBAN'
  ]);
  return OGM(
    structuredMessage: json['structuredMessage'] as String,
    beneficiary: json['beneficiary'] as String,
    beneficiaryIBAN: json['beneficiaryIBAN'] as String,
  );
}

Map<String, dynamic> _$OGMToJson(OGM instance) => <String, dynamic>{
      'structuredMessage': instance.structuredMessage,
      'beneficiary': instance.beneficiary,
      'beneficiaryIBAN': instance.beneficiaryIBAN,
    };
