// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_profile_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminProfileData _$AdminProfileDataFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'firstName',
      'lastName',
      'standardLanguage',
      'mainAccountNumber',
      'legalEmail',
      'phones',
      'legalAddress',
      'additionalField',
      'privileges'
    ],
  );
  return AdminProfileData(
    privileges: json['privileges'] as String,
    additionalField: json['additionalField'] as String,
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

Map<String, dynamic> _$AdminProfileDataToJson(AdminProfileData instance) {
  final val = <String, dynamic>{
    'firstName': instance.firstName,
    'lastName': instance.lastName,
    'standardLanguage': instance.standardLanguage,
    'mainAccountNumber': instance.mainAccountNumber,
    'legalEmail': instance.legalEmail,
    'phones': instance.phones.toJson(),
    'legalAddress': instance.legalAddress.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offTrack', instance.offTrack);
  val['onTrack'] = instance.onTrack?.map((e) => e.toJson()).toList();
  writeNotNull('persons', instance.persons?.map((e) => e.toJson()).toList());
  writeNotNull('personsById',
      instance.personsById?.map((k, e) => MapEntry(k, e.toJson())));
  val['additionalField'] = instance.additionalField;
  val['privileges'] = instance.privileges;
  return val;
}
