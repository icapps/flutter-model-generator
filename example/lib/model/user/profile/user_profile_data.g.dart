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
    phones: json['phones'] == null
        ? null
        : Testing.fromJson(json['phones'] as Map<String, dynamic>),
    legalAddress: json['legalAddress'] == null
        ? null
        : OGM.fromJson(json['legalAddress'] as Map<String, dynamic>),
    offTrack: (json['offTrack'] as List)?.map((e) => e as String)?.toList(),
    onTrack: (json['onTrack'] as List)
        ?.map((e) => e == null ? null : OGM.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserProfileDataToJson(UserProfileData instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'standardLanguage': instance.standardLanguage,
      'mainAccountNumber': instance.mainAccountNumber,
      'legalEmail': instance.legalEmail,
      'phones': instance.phones,
      'legalAddress': instance.legalAddress,
      'offTrack': instance.offTrack,
      'onTrack': instance.onTrack,
    };
