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
  Gender.gender_x: 'gender_x',
  Gender.gender_y: 'gender_y',
  Gender.gender_z: 'gender_z',
  Gender.gender_abc: 'gender_abc',
  Gender.gender_def: 'gender_def',
  Gender.gender_lap: 'GENDER_lap',
};
