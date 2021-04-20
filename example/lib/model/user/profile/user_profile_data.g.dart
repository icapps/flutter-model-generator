// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileData _$UserProfileDataFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'firstName',
    'lastName',
    'standardLanguage',
    'mainAccountNumber',
    'legalEmail',
    'phones',
    'legalAddress'
  ]);
  return UserProfileData(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    standardLanguage: json['standardLanguage'] as String,
    mainAccountNumber: json['mainAccountNumber'] as String,
    legalEmail: json['legalEmail'] as String,
    phones: Testing.fromJson(json['phones'] as Map<String, dynamic>),
    legalAddress: OGM.fromJson(json['legalAddress'] as Map<String, dynamic>),
    offTrack:
        (json['offTrack'] as List<dynamic>?)?.map((e) => e as String).toList(),
    onTrack: (json['onTrack'] as List<dynamic>?)
        ?.map((e) => OGM.fromJson(e as Map<String, dynamic>))
        .toList(),
    persons: (json['persons'] as List<dynamic>?)
        ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
        .toList(),
    personsById: (json['personsById'] as Map<String, dynamic>?)?.map(
      (k, e) => MapEntry(k, Person.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$UserProfileDataToJson(UserProfileData instance) {
  final val = <String, dynamic>{
    'firstName': instance.firstName,
    'lastName': instance.lastName,
    'standardLanguage': instance.standardLanguage,
    'mainAccountNumber': instance.mainAccountNumber,
    'legalEmail': instance.legalEmail,
    'phones': instance.phones,
    'legalAddress': instance.legalAddress,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offTrack', instance.offTrack);
  val['onTrack'] = instance.onTrack;
  val['persons'] = instance.persons;
  val['personsById'] = instance.personsById;
  return val;
}
