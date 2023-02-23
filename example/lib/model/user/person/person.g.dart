// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['firstName', 'gender'],
  );
  return Person(
    firstName: json['firstName'] as String,
    gender:
        $enumDecode(_$GenderEnumMap, json['gender'], unknownValue: Gender.X),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'gender': _$GenderEnumMap[instance.gender]!,
    };

const _$GenderEnumMap = {
  Gender.MALE: '_mAl3',
  Gender.FEMALE: 'femAle',
  Gender.X: 'X',
  Gender.GENDER_X: 'GENDER_X',
  Gender.GENDER_Y: 'null',
  Gender.GENDER_Z: 'gender_z',
  Gender.GENDER_ABC: 'GENDER_abC',
  Gender.GENDER_DEF: 'null',
  Gender.GENDER_LAP: 'GENDER_lap',
};
