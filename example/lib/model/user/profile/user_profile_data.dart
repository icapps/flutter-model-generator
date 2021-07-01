import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:model_generator_example/model/user/testing.dart';
import 'package:model_generator_example/model/ogm.dart';
import 'package:model_generator_example/model/user/person/person.dart';

part 'user_profile_data.g.dart';

@JsonSerializable(explicitToJson: true)
@immutable
class UserProfileData {
  @JsonKey(name: 'firstName', required: true, includeIfNull: false)
  final String firstName;
  @JsonKey(name: 'lastName', required: true, includeIfNull: false)
  final String lastName;
  @JsonKey(name: 'standardLanguage', required: true, includeIfNull: false)
  final String standardLanguage;
  @JsonKey(name: 'mainAccountNumber', required: true, includeIfNull: false)
  final String mainAccountNumber;
  @JsonKey(name: 'legalEmail', required: true, includeIfNull: false)
  final String legalEmail;
  @JsonKey(name: 'phones', required: true, includeIfNull: false)
  final Testing phones;
  @JsonKey(name: 'legalAddress', required: true, includeIfNull: false)
  final OGM legalAddress;
  @JsonKey(name: 'offTrack', includeIfNull: false)
  final List<String>? offTrack;
  @JsonKey(name: 'onTrack')
  final List<OGM>? onTrack;
  @JsonKey(name: 'persons', includeIfNull: false)
  final List<Person>? persons;
  @JsonKey(name: 'personsById', includeIfNull: false)
  final Map<String, Person>? personsById;

  const UserProfileData({
    required this.firstName,
    required this.lastName,
    required this.standardLanguage,
    required this.mainAccountNumber,
    required this.legalEmail,
    required this.phones,
    required this.legalAddress,
    this.offTrack,
    this.onTrack,
    this.persons,
    this.personsById,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => _$UserProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileData &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          standardLanguage == other.standardLanguage &&
          mainAccountNumber == other.mainAccountNumber &&
          legalEmail == other.legalEmail &&
          phones == other.phones &&
          legalAddress == other.legalAddress &&
          offTrack == other.offTrack &&
          onTrack == other.onTrack &&
          persons == other.persons &&
          personsById == other.personsById;

  @override
  int get hashCode =>
      firstName.hashCode ^
      lastName.hashCode ^
      standardLanguage.hashCode ^
      mainAccountNumber.hashCode ^
      legalEmail.hashCode ^
      phones.hashCode ^
      legalAddress.hashCode ^
      offTrack.hashCode ^
      onTrack.hashCode ^
      persons.hashCode ^
      personsById.hashCode;

  @override
  String toString() =>
      'UserProfileData{'
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
