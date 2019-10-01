// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ogm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OGM _$OGMFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['beneficiary', 'structuredMessage', 'beneficiaryIBAN']);
  return OGM(
    json['beneficiary'] as String,
    json['structuredMessage'] as String,
    json['beneficiaryIBAN'] as String,
  );
}

Map<String, dynamic> _$OGMToJson(OGM instance) => <String, dynamic>{
      'beneficiary': instance.beneficiary,
      'structuredMessage': instance.structuredMessage,
      'beneficiaryIBAN': instance.beneficiaryIBAN,
    };
