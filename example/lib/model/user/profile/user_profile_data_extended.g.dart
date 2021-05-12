// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_data_extended.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDataExtended _$UserProfileDataExtendedFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['additionalField']);
  return UserProfileDataExtended(
    additionalField: json['additionalField'] as String,
  );
}

Map<String, dynamic> _$UserProfileDataExtendedToJson(
        UserProfileDataExtended instance) =>
    <String, dynamic>{
      'additionalField': instance.additionalField,
    };
