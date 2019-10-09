// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileData _$UserProfileDataFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['firstName', 'legalAddress', 'phones', 'legalEmail', 'standardLanguage', 'lastName', 'mainAccountNumber']);
  return UserProfileData(
    json['firstName'] as String,
    OGM.fromJson(json['legalAddress'] as Map<String, dynamic>),
    Testing.fromJson(json['phones'] as Map<String, dynamic>),
    (json['offTrack'] as List).map((e) => e as String).toList(),
    json['legalEmail'] as String,
    (json['onTrack'] as List).map((e) => OGM.fromJson(e as Map<String, dynamic>)).toList(),
    json['standardLanguage'] as String,
    json['lastName'] as String,
    json['mainAccountNumber'] as String,
  );
}

Map<String, dynamic> _$UserProfileDataToJson(UserProfileData instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'legalAddress': instance.legalAddress,
      'phones': instance.phones,
      'offTrack': instance.offTrack,
      'legalEmail': instance.legalEmail,
      'onTrack': instance.onTrack,
      'standardLanguage': instance.standardLanguage,
      'lastName': instance.lastName,
      'mainAccountNumber': instance.mainAccountNumber,
    };
