// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:model_generator_example/model/ogm.dart';
import 'package:model_generator_example/model/user/person/person.dart';
import 'package:model_generator_example/model/user/profile/user_profile_data_extended.dart';
import 'package:model_generator_example/model/user/testing.dart';

part 'admin_profile_data.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class AdminProfileData extends UserProfileDataExtended {
  @JsonKey(name: 'privileges', required: true, includeIfNull: false)
  final String privileges;

  const AdminProfileData({
    required this.privileges,
    required String additionalField,
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
          additionalField: additionalField,
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

  factory AdminProfileData.fromJson(Map<String, dynamic> json) =>
      _$AdminProfileDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdminProfileDataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminProfileData &&
          runtimeType == other.runtimeType &&
          privileges == other.privileges &&
          super == other;

  @override
  int get hashCode => privileges.hashCode ^ super.hashCode;

  @override
  String toString() => 'AdminProfileData{'
      'privileges: $privileges, '
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

AdminProfileData deserializeAdminProfileData(Map<String, dynamic> json) =>
    AdminProfileData.fromJson(json);

Map<String, dynamic> serializeAdminProfileData(AdminProfileData object) =>
    object.toJson();

List<AdminProfileData> deserializeAdminProfileDataList(
        List<Map<String, dynamic>> jsonList) =>
    jsonList.map((json) => AdminProfileData.fromJson(json)).toList();

List<Map<String, dynamic>> serializeAdminProfileDataList(
        List<AdminProfileData> objects) =>
    objects.map((object) => object.toJson()).toList();
