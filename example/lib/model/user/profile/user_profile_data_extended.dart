// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/ogm.dart';
import 'package:model_generator_example/model/user/person/person.dart';
import 'package:model_generator_example/model/user/profile/user_profile_data.dart';
import 'package:model_generator_example/model/user/testing.dart';

part 'user_profile_data_extended.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class UserProfileDataExtended extends UserProfileData {
  @JsonKey(name: 'additionalField', required: true, includeIfNull: false)
  final String additionalField;

  const UserProfileDataExtended({
    required this.additionalField,
    required String firstName,
    required String lastName,
    required String standardLanguage,
    required String mainAccountNumber,
    required String legalEmail,
    required Testing phones,
    required OGM legalAddress,
    List<String>? offTrack,
    List<OGM>? onTrack,
    List<Person>? persons,
    Map<String, Person>? personsById,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          standardLanguage: standardLanguage,
          mainAccountNumber: mainAccountNumber,
          legalEmail: legalEmail,
          phones: phones,
          legalAddress: legalAddress,
          offTrack: offTrack,
          onTrack: onTrack,
          persons: persons,
          personsById: personsById,
        );

  factory UserProfileDataExtended.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDataExtendedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserProfileDataExtendedToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileDataExtended &&
          runtimeType == other.runtimeType &&
          additionalField == other.additionalField &&
          super == other;

  @override
  int get hashCode => additionalField.hashCode ^ super.hashCode;

  @override
  String toString() => 'UserProfileDataExtended{'
      'additionalField: $additionalField, '
      'firstName: $firstName, '
      'lastName: $lastName, '
      'standardLanguage: $standardLanguage, '
      'mainAccountNumber: $mainAccountNumber, '
      'legalEmail: $legalEmail, '
      'phones: $phones, '
      'legalAddress: $legalAddress, '
      'offTrack: $offTrack, '
      'onTrack: $onTrack, '
      'persons: $persons, '
      'personsById: $personsById'
      '}';
}

const deserializeUserProfileDataExtended = UserProfileDataExtended.fromJson;

Map<String, dynamic> serializeUserProfileDataExtended(
        UserProfileDataExtended object) =>
    object.toJson();

List<UserProfileDataExtended> deserializeUserProfileDataExtendedList(
        List<Map<String, dynamic>> jsonList) =>
    jsonList.map(UserProfileDataExtended.fromJson).toList();

List<Map<String, dynamic>> serializeUserProfileDataExtendedList(
        List<UserProfileDataExtended> objects) =>
    objects.map((object) => object.toJson()).toList();
