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
        $enumDecode(_$GenderEnumMap, json['gender'], unknownValue: Gender.x),
  );
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'gender': _$GenderEnumMap[instance.gender]!,
    };

const _$GenderEnumMap = {
  Gender.male: '_mAl3',
  Gender.female: 'femAle',
  Gender.x: 'X',
  Gender.genderX: 'gender_x',
  Gender.genderY: 'gender_y',
  Gender.genderZ: 'gender_z',
  Gender.genderAbc: 'gender_abc',
  Gender.genderDef: 'gender_def',
  Gender.genderLap: 'GENDER_lap',
};
