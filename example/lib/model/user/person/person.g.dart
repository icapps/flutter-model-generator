// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['firstName', 'gender']);
  return Person(
    firstName: json['firstName'] as String,
    gender: _$enumDecodeNullable(_$GenderEnumMap, json['gender']),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'gender': _$GenderEnumMap[instance.gender],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GenderEnumMap = {
  Gender.MALE: '_mAl3',
  Gender.FEMALE: 'femAle',
  Gender.X: 'X',
  Gender.GENDER_X: 'GENDER_X',
  Gender.GENDER_Y: 'GENDER_Y',
  Gender.GENDER_Z: 'gender_z',
  Gender.GENDER_ABC: 'GENDER_abC',
  Gender.GENDER_DEF: 'GENDER_def',
  Gender.GENDER_LAP: 'GENDER_lap',
};
