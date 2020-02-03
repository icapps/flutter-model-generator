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
  );
}

Map<String, dynamic> _$TestingToJson(Testing instance) => <String, dynamic>{
      'beneficiary': instance.beneficiary,
      'structuredMessage': instance.structuredMessage,
      'beneficiaryIBAN': instance.beneficiaryIBAN,
    };
